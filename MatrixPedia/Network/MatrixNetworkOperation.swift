//
//  NetworkOperation.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

protocol MatrixNetworkOperation {
    var error: NSError? { get }
    var endPoint: String { get }
    
    func finish(with data: Data?)
}

extension MatrixNetworkOperation {
    var error: NSError? {
        return nil // This should be implemented by childs
    }
    
    var endPoint: String {
        return "" // This should be implemented by childs
    }
    
    func finish(with data: Data?) {
        // This should be implemented by childs
    }
}
