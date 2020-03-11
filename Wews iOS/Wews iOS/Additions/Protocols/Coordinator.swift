//
//  Coordinator.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/26/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit

#warning("UnitTest BaseCoordinator & RootCoordinator protocols")
protocol BaseCoordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

protocol RootCoordinator: class {
    var rootViewController: UIViewController { get }
}

extension BaseCoordinator {
    /// Add a child coordinator to the parent
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    /// Remove a child coordinator from the parent
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

typealias Coordinator = BaseCoordinator & RootCoordinator
