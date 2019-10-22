//
//  UIViewController.swift
//  Weather
//
//  Created by Thành Đỗ Long on 11/09/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

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
            let action = UIAlertAction(title: "OK", style: .cancel, handler: handler)
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil )
    }
}

// MARK: Display indicator Extensions
extension UIViewController {
    func showActivityIndicatory(onView: UIView, offset: CGFloat = 0) -> UIView {
        
        let boxView = UIView(frame: CGRect(x: (view.center.x - 40), y: (view.center.y - 40) + offset, width: 80, height: 80))
        boxView.backgroundColor = UIColor.gray
        boxView.layer.cornerRadius = 10
        
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: view.center.x, y: view.center.y + offset)
        
        DispatchQueue.main.async {
            spinnerView.addSubview(boxView)
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeIndicator(indicator: UIView) {
        DispatchQueue.main.async {
            indicator.removeFromSuperview()
        }
    }
}
