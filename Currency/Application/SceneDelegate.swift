//
//  SceneDelegate.swift
//  Currency
//
//  Created by Thành Đỗ Long on 21/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    public lazy var appDependency = AppDependency()
    public lazy var coordinator = HomeCoordinator(router: router, container: appDependency.container)
    public lazy var router = AppDelegateRouter(window: window!)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            window?.windowScene = windowScene
            coordinator.present(animated: true, onDismissed: nil)
        }
    }
}
