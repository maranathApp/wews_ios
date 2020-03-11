//
//  AppCoordinator.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/26/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - INTERNAL ATTRIBUTES

    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { viewControllerToPresent ?? UIViewController() }

    // MARK: - PRIVATE METHODS

    private var viewControllerToPresent: UIViewController?

    // MARK: - INTERNAL METHODS

    func start() {
        showMainCoordinator()
    }

    // MARK: - PRIVATE METHODS

    private func showMainCoordinator() {
        let mainCoordinator = CoordinatorProvider.main
        mainCoordinator.start()
        viewControllerToPresent = mainCoordinator.rootViewController
        childCoordinators.append(mainCoordinator)
    }

    private func showOnBoardingCoordinator() {
        let onBoardingCoordinator = CoordinatorProvider.onBoarding
        onBoardingCoordinator.start()
        viewControllerToPresent = onBoardingCoordinator.rootViewController
        childCoordinators.append(onBoardingCoordinator)
    }
}
