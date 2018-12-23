//
//  MainRouter.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

typealias MainRouterProtocols = MainRouter & MainViewControllerHandler

protocol MainViewControllerHandler {
    func installMainViewController()
    func installRootViewController(_ viewController: UIViewController)
}

protocol MainRouter: class {
    var rootViewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
    var currentViewController: UIViewController? { get }
    func present(controller: UIViewController)
}

class MainRouterImpl {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
}

extension MainRouterImpl: MainRouter {
    var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    var navigationController: UINavigationController? {
        guard let navigationController = rootViewController as? UINavigationController else {
            return nil
        }
        
        return navigationController
    }
    
    var currentViewController: UIViewController? {
        
        var currentController: UIViewController?
        
        if let navController = navigationController {
            currentController = navController.topViewController
        } else {
            currentController = rootViewController
        }
        
        while let presentedController = currentController?.presentedViewController, !presentedController.isBeingDismissed {
            
            if let presentedNavController = presentedController as? UINavigationController {
                currentController = presentedNavController
            } else {
                currentController = presentedController
            }
        }
        
        return currentController
    }
    
    func present(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainRouterImpl: MainViewControllerHandler {
    func installMainViewController() {
        installMainView(animated: true)
    }
    
    func installRootViewController(_ viewController: UIViewController) {
        self.window?.rootViewController = viewController
    }
}

extension MainRouterImpl {
    func installMainView(animated: Bool) {
        let serviceLocator = UIApplication.serviceLocator
        let charactersListVC = CharacterListRouterImpl.create(withNetworkDataManager: serviceLocator.networkDataManager)
        let navigationController = UINavigationController(rootViewController: charactersListVC)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

