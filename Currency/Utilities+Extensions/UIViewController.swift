//
//  UIViewController.swift
//  Weather
//
//  Created by Thành Đỗ Long on 11/09/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import Foundation

// MARK: Alert Extensions
extension UIViewController {
    func presentAlertAction(withTitle title: String?,
                            message: String?,
                            alertActions: [UIAlertAction]? = nil,
                            handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let alertActions = alertActions {
            for action in alertActions {
                alert.addAction(action)
            }
        } else {
            let action = UIAlertAction(title: "OK", style: .default, handler: handler)
            alert.addAction(action)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil )
        }
    }
}

// MARK: Display indicator Extensions
extension UIViewController {
    func showActivityIndicatory(onView: UIView, offset: CGFloat = 0) -> UIView {
        let window = UIWindow(frame: UIScreen.main.bounds)

        let containerView = UIView()
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.systemGray2.withAlphaComponent(0.3)

        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.systemGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: loadingView.bounds.width/2, y: loadingView.bounds.height/2 + offset)

        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        containerView.addSubview(loadingView)

        onView.addSubview(containerView)

        return containerView
    }

    func removeIndicator(indicator: UIView?) {
        guard let indicator = indicator else { return }

        DispatchQueue.main.async {
            indicator.removeFromSuperview()
        }
    }
}
