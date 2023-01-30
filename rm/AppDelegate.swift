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
        setupNavBar()
        if #available(iOS 13.0, *) {
            window = UIWindow()
            window?.makeKeyAndVisible()
        } else {
            window = UIWindow()
            window?.tintColor = .mainColor
//            let vc = TabBarController()
            let vc = UINavigationController(rootViewController: SelectedServicesListVC())
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    func setupNavBar() {
        let backImg = UIImage(named: "Left")
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 0
        let largeTitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(font: .H1),
            NSAttributedString.Key.paragraphStyle: style
        ]
        UINavigationBar.appearance().barTintColor = .backgroundColor
        UINavigationBar.appearance().backgroundColor = .backgroundColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().largeTitleTextAttributes = largeTitleAttributes
        UINavigationBar.appearance().backIndicatorImage = backImg
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImg
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

