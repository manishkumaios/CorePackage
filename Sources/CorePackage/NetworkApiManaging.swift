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
    case error(ApiError)
}

@frozen
public enum ApiError: Error {
    case unexpected
    case api
}

protocol NetworkApiManaging {
    func request<T: Decodable>(url: String, params: [String : Any], callback:  @escaping (Data?, ApiStatus, T?) -> Void)
    func downloadAndCacheImages(url: String, params: [String: Any], callback:  @escaping (Data?, ApiStatus) -> UIImage?)
}
