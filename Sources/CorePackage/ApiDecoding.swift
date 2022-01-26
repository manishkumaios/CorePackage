//
//  ApiDecoding.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation

protocol ApiDecoding {
    func decode<T: Decodable>(from response: Data, type: T.Type) throws -> T?
}

struct ApiDecoder: ApiDecoding {
    func decode<T: Decodable>(from response: Data, type: T.Type) throws -> T? {
        let jsonDecoder =  JSONDecoder()
        return try jsonDecoder.decode(T.self, from: response)
    }
}
