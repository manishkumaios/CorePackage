//
//  NetworkApiManaging.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import UIKit

@frozen
public enum ApiStatus {
    case success
    case error(Error)
}

protocol NetworkApiManaging {
    func getAPiResponse<T: Codable>(url: String, params: [String: Any], callback: (Data?, ApiStatus) -> T?)
    func downloadAndCacheImages(url: String, params: [String: Any], callback: (Data?, ApiStatus) -> UIImage?)
}
