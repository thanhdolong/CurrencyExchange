//
//  AppDelegateRouter.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

public class AppDelegateRouter: Router {

  // MARK: - Instance Properties
  public let window: UIWindow

  // MARK: - Object Lifecycle
  public init(window: UIWindow) {
    self.window = window
  }

  // MARK: - Router
  public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }

  public func dismiss(animated: Bool) {
    // don't do anything
  }
}
