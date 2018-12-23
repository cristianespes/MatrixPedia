//
//  AppDelegate.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 22/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createWindow()
        installRootViewController()
        
        return true
    }
}

extension AppDelegate {
    func createWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func installRootViewController() {
        let handler: MainViewControllerHandler = UIApplication.serviceLocator.mainRouter
        handler.installMainViewController()
    }
}

