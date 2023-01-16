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
    let backImg = UIImage(named: "Left")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().backgroundColor = .backgroundColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = backImg
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImg
        fixiOS15NavBarIssues()
        let vc = UINavigationController(rootViewController: LoginVC())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func fixiOS15NavBarIssues() {
       if #available(iOS 15, *) {
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
//           appearance.backButtonAppearance.normal.
           appearance.backgroundColor = .backgroundColor //customised nav bar background color
           appearance.setBackIndicatorImage(backImg, transitionMaskImage: backImg)
           appearance.shadowColor = .clear //removes the nav bar shadow
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
       }
     }

}

