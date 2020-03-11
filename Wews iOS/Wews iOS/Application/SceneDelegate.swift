//
//  SceneDelegate.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/5/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - INTERNAL ATTRIBUTES

    var window: UIWindow?
    let appCoordinator: AppCoordinator = CoordinatorProvider.app

    // MARK: - PRIVATE METHODS

    private func setUpAppCoordinator(with windowScene: UIWindowScene) {
        appCoordinator.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        window?.rootViewController = appCoordinator.rootViewController
    }

    // MARK: - UIWINDOWSCENEDELEGATES METHODS

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        setUpAppCoordinator(with: windowScene)
    }
}
