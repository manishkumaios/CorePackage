//
//  NetworkApiProvider.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import UIKit
import NetworkPackage

public protocol CorePackageDataManaging {
    var shouldUseOwnNetworkInterface: Bool { get }
}

public class NetworkApiProvider: NetworkApiManaging {
    
    private let dataSource: CorePackageDataManaging
    
    public init(dataSource: CorePackageDataManaging) {
        self.dataSource = dataSource
    }
    
    private lazy var webIntegrator: WebIntegrator = {
        struct WebIntegratorDS: WebApiIntegrating {
            var shouldUseOwnNetworkInterface: Bool
        }
        let integrator = WebIntegrator.init(dataSource: WebIntegratorDS.init(shouldUseOwnNetworkInterface: dataSource.shouldUseOwnNetworkInterface))
        return integrator
    }()
    
    public func request<T: Decodable>(url: String, params: [AnyHashable : Any]?, requestType: RequestType, callback:  @escaping (Data?, ApiStatus, T?) -> Void)  {
        guard let url = URL(string: url) else {
            callback(nil, .error(.unexpected), nil)
            return
        }
        
        webIntegrator.fetch(url: url) { data, response, error in
            guard let response = response else {
                callback(nil, .error(.unexpected), nil)
                return
            }
            
            guard let data = data else {
                callback(nil, .error(.unexpected), nil)
                return
            }
            
            let decodedData = try? ApiDecoder().decode(from: data, type: T.self)
            callback(data, self.consolidateError(response: response), decodedData)
        }
    }
    
    public func downloadImages(url: String, params: [AnyHashable: Any]?, callback:  @escaping (Data?, ApiStatus) -> Void) {
        guard let url = URL(string: url) else {
            callback(nil, .error(.unexpected))
            return
        }
        
        webIntegrator.downloadImage(url: url) { data, response, error in
            guard let _ = response else {
                callback(nil, .error(.unexpected))
                return
            }
            guard let data = data else {
                callback(nil, .error(.unexpected))
                return
            }
            
            callback(data, .success)
        }
    }
}

private extension NetworkApiProvider {
    func consolidateError(response: URLResponse) -> ApiStatus {
        guard let statusCode = response.getStatusCode() else {
            return .error(.unexpected)
        }
        switch statusCode {
        case 200:
            return .success
        default:
            return .error(.api)
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
