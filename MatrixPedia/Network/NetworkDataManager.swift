//
//  NetworkDataManager.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkDataManagerCompletionHandler = (_ error: NSError?) -> Void

protocol NetworkDataManager {
    func execute(_ operation: MatrixNetworkOperation, completionHandler: @escaping NetworkDataManagerCompletionHandler)
}

class NetworkDataManagerImpl: NetworkDataManager {
    var uriRoot: String
    
    init(withUriRoot uriRoot: String) {
        self.uriRoot = uriRoot
    }
    
    func execute(_ operation: MatrixNetworkOperation, completionHandler: @escaping NetworkDataManagerCompletionHandler) {
        guard let url = URL(string: uriRoot + operation.endPoint) else {
            completionHandler(getError(withType: .unknown, description: "Error creating URL"))
            return
        }
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            operation.finish(with: response.data)
            completionHandler(nil)
        }
    }
}

extension NetworkDataManager {
    func getError(withType type: NetworkDataManagerErrorCode, description: String?) -> NSError {
        return NSError(domain: "NetworkDataManager", code: type.rawValue, userInfo: [NSLocalizedDescriptionKey: description ?? ""])
    }
}

enum NetworkDataManagerErrorCode: Int {
    case unknown = -1
    case operation
    case parsing
}
