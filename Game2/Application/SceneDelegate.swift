//
//  SceneDelegate.swift
//  Game2
//
//  Created by Семен Безгин on 12.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = ViewController() // Your initial view controller.
//        window.rootViewController = SearchingCabinetViewController()
//        window.rootViewController = TestViewController()
//        window.rootViewController = NewTestViewController()
        window.makeKeyAndVisible()
        
        
        
        let controller = ViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.overrideUserInterfaceStyle = .light
//        navController.isNavigationBarHidden = true
//        navController.navigationItem.hidesBackButton = true
        window.rootViewController = navController
        
        
        
        self.window = window
    }
}

