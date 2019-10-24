//
//  Coordinator.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Swinject

protocol Coordinator: class {
    
    var children: [Coordinator] { get set }
    var router: Router { get }
    var container: Container { get }
    
    func present(animated: Bool, onDismissed: (() -> Void)?)
    func dismiss(animated: Bool)
    func presentChild(_ child: Coordinator,
                      animated: Bool,
                      onDismissed: (() -> Void)?)
}

extension Coordinator {
    
    public func dismiss(animated: Bool) {
        router.dismiss(animated: true)
    }
    
    public func presentChild(_ child: Coordinator,
                             animated: Bool,
                             onDismissed: (() -> Void)? = nil) {
        children.append(child)
        child.present(animated: animated, onDismissed: { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChild(child)
            onDismissed?()
        })
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === child })
            else {
                return
        }
        children.remove(at: index)
    }
}
