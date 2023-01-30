//
//  TabBarController.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setupUI()
    }
    
    func setupUI() {
        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: .redColorr)
        tabBar.unselectedItemTintColor = .passiveTextColor
        tabBar.backgroundColor = .white
        tabBar.tintColor = .white
        tabBar.barTintColor = .backgroundColor
        tabBar.backgroundColor = .cardColor
        updateTabBarItemFont()
    }
    
    func updateTabBarItemFont() {
        let normal = [NSAttributedString.Key.font: UIFont(font: .B4)]
        let selected = [NSAttributedString.Key.font: UIFont(font: .B4)]
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .cardColor
            appearance.shadowImage = UIImage.colorForNavBar(color: .strokeColor)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normal
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selected
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            } else { }
        } else {
//            UITabBar.appearance().backgroundColor = .backgroundColor
            UITabBarItem.appearance().setTitleTextAttributes(normal, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selected, for: .selected)
        }
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeVC(), title: "Home", image: UIImage(named: "home")!),
            createNavController(for: StatusVC(), title: "Service", image: UIImage(named: "Car")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
      }
    
}

