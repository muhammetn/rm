//
//  AppDelegate.swift
//  rm
//
//  Created by Muhammet Nurchayev on 13.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window = UIWindow()
            window?.makeKeyAndVisible()
        } else {
            window = UIWindow()
            window?.tintColor = .mainColor
            let vc = TabBarController()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        return true
    }
    
}

