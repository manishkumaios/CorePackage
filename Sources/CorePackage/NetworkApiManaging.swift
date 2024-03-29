//
//  NetworkApiManaging.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation


public enum RequestType {
    case get
    case post
    case put
    case delete
}

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
    func request<T: Decodable>(url: String, params: [AnyHashable : Any]?, requestType: RequestType, callback:  @escaping (Data?, ApiStatus, T?) -> Void)
    func downloadImages(url: String, params: [AnyHashable: Any]?, callback:  @escaping (Data?, ApiStatus) -> Void)
}
