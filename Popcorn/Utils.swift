//
//  Utils.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import Foundation

class Utils {
  static let jsonDecoder : JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    return jsonDecoder
  }()
  
  static let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    return dateFormatter
  }()  
  
}
