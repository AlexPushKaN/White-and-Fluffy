//
//  SceneDelegate.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let networkingService = NetworkingService()
        let appViewModel = AppViewModel(networkingService: networkingService)
        
        let rootController = TabBarController(appViewModel: appViewModel)
        window.rootViewController = rootController
        self.window = window
        window.makeKeyAndVisible()
    }
}
