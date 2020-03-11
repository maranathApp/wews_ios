//
//  ViewControllerProvider+Navigation.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation

extension ViewControllerProvider {
    enum Navigation {
        static var split: SplitViewController {
            let splitViewController = SplitViewController()
            splitViewController.viewControllers = [
                ViewControllerProvider.Main.master.embedInNavigationController(),
                ViewControllerProvider.Main.detail.embedInNavigationController()]

            return splitViewController
        }
    }
}
