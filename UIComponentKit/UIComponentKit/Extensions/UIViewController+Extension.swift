//
//  UIViewController+Extension.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2019 MaranathApp. All rights reserved.
//

import UIKit.UIViewController

#warning("To be tested")
public extension UIViewController {
    var name: String {
        return String(describing: self)
    }

    func embedInNavigationController(prefersLargeTitles: Bool = false) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
            navigationController.modalPresentationStyle = .pageSheet
        }

        return navigationController
    }
}
