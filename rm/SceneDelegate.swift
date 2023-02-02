//
//  SceneDelegate.swift
//  rm
//
//  Created by Muhammet Nurchayev on 13.01.2023.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        setNavBar()
        var vc = UIViewController()
        if AuthHelper.shared.auth {
            vc = UINavigationController(rootViewController: CarSelectionVC())
        } else {
            vc = UINavigationController(rootViewController: LoginVC())
        }
//        let vc = TabBarController()
//        let vc = UINavigationController(rootViewController: StatusVC())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func setNavBar() {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 0
        let backImg = UIImage(named: "Left")
        let largeTitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(font: .H1),
            NSAttributedString.Key.paragraphStyle: style
        ]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = largeTitleAttributes
        appearance.backgroundColor = .backgroundColor //customised nav bar background color
        appearance.setBackIndicatorImage(backImg, transitionMaskImage: backImg)
        appearance.shadowColor = .clear //removes the nav bar shadow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
     }

}

