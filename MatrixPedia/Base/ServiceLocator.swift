//
//  ServiceLocator.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

final class ServiceLocator {
    lazy var networkDataManager: NetworkDataManager = {
        let manager = NetworkDataManagerImpl(withUriRoot: "http://localhost")
        return manager
    }()
    
    lazy var mainRouter: MainRouterProtocols = { [unowned self] in
        let window = UIApplication.shared.keyWindow
        let mainRouter = MainRouterImpl(window: window)
        return mainRouter
    }()
}
