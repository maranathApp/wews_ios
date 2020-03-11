//
//  OnBoardingCoordinator.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/26/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {

    // MARK: - INTERNAL ATTRIBUTES

    var childCoordinators: [Coordinator] = []

    lazy var navigationController = UIViewController()
    lazy var onBoardingHubViewController = UIViewController()

    var rootViewController: UIViewController {
        return self.navigationController
    }

    // MARK: - INTERNAL METHODS

    func start() {}
}
