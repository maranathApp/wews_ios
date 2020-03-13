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

    var rootViewController: UIViewController {
        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [
            masterViewController.embedInNavigationController(),
            detailViewController.embedInNavigationController()]

        return splitViewController
    }

    // MARK: - PRIVATE ATTRIBUTES

    private let masterViewController = ViewControllerProvider.Main.master
    private let detailViewController = ViewControllerProvider.Main.detail

    // MARK: - INITIALIZERS

    init() {
        masterViewController.delegate = self
        detailViewController.delegate = self
    }

    // MARK: - INTERNAL METHODS

    func start() {}
}

extension MainCoordinator: MasterViewControllerDelegate {
    func didPresentDetailViewController(_ vc: MasterViewController, detailViewModel: DetailViewModel) {
        detailViewController.viewModel.setUp(with: detailViewModel.title ?? "", imageURL: detailViewModel.imageURL, description: detailViewModel.description ?? "", link: detailViewModel.link)

        if UIDevice.type == .iPhone {
            vc.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension MainCoordinator: DetailViewControllerDelegate {
    func didPresentWebViewController(_ vc: DetailViewController, with webViewModel: WebViewModel) {
        detailViewController.present(ViewControllerProvider.Main.web(with: webViewModel).embedInNavigationController(), animated: true)
    }
}
