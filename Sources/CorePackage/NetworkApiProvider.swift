//
//  NetworkApiProvider.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import UIKit

public protocol CorePackageDataManaging {
    var shouldUseOwnNetworkInterface: Bool { get }
}

public struct NetworkApiProvider: NetworkApiManaging {
    private let dataSource: CorePackageDataManaging
    
    public init(dataSource: CorePackageDataManaging) {
        self.dataSource = dataSource
    }
    
    func getAPiResponse<T>(url: String, params: [String : Any], callback: (Data?, ApiStatus) -> T?) where T : Decodable, T : Encodable {
        
    }
    
    func downloadAndCacheImages(url: String, params: [String : Any], callback: (Data?, ApiStatus) -> UIImage?) {
        
    }
}
