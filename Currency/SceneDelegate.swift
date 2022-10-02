//
//  SceneDelegate.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let vc = CCConverterViewController()
        window.rootViewController = CCNavigationController(rootViewController:vc)
        self.window = window
        window.makeKeyAndVisible()
    }
}

