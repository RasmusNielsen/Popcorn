//
//  ImageLoader.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import Foundation
import UIKit
import SwiftUI

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache

    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
          withAnimation {
                     self.image = imageFromCache
                 }
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                  withAnimation {
                    self?.image = image
                  }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
