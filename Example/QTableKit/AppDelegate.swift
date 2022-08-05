//
//  AppDelegate.swift
//  QTableKit
//
//  Created by mac on 2022/7/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabbar = RootViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds);
        if let window = window {
            window.backgroundColor = UIColor.white
            window.rootViewController = UINavigationController(rootViewController: tabbar)
            window.makeKeyAndVisible()
        }
        return true
    }

}

