//
//  MainCoordinator.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {

    // MARK: - INTERNAL ATTRIBUTES

    var childCoordinators: [Coordinator] = []
    lazy var onBoardingHubViewController = UIViewController()

    var rootViewController: UIViewController {
        return ViewControllerProvider.Navigation.split
    }

    // MARK: - INTERNAL METHODS

    func start() {}
}
