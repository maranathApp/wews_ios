//
//  MasterViewController.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit
import UIComponentKit
import Combine

final class MasterViewController: CollectionViewController<MasterCollectionViewCell, MasterViewModel> {

    // MARK: - PRIVATE ATTRIBUTES

    private var detailViewController: DetailViewController?
    private let interItemSpacing: CGFloat = 16
    private let edgeSpacingInset: CGFloat = 8

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = interItemSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        layout.sectionInset = UIEdgeInsets(top: edgeSpacingInset, left: interItemSpacing, bottom: edgeSpacingInset, right: interItemSpacing)

        return layout
    }()

    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFit
        
        return view
    }()

    // MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }

    // MARK: - PRIVATE METHODS

    private func setUpUI() {
        setUpCollectionView(with: collectionViewLayout)
        collectionView.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.titleView = logoImageView

        if let split = splitViewController,
            let detailViewController = (split.viewControllers[split.viewControllers.count-1] as? UINavigationController)?.topViewController as? DetailViewController {
            self.detailViewController = detailViewController
        } else {
            self.detailViewController = ViewControllerProvider.Main.detail
        }

        viewModel.loadData()
    }

    private func bindViewModel() {
        viewModel
            .shouldReloadData
            .sink { [weak collectionView] in
                collectionView?.reloadData()
        }
        .store(in: &viewModel.cancellables)

        viewModel
            .viewStateChanged
            .sink { [weak self] state in
                self?.handle(state: state)
        }
        .store(in: &viewModel.cancellables)
    }

    private func handle(state: ViewState) {
        #warning("To implement")
    }

    // MARK: UICOLLECTIONVIEWDELEGATE

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItem(for: indexPath)
        detailViewController?.viewModel.setUp(with: item.title ?? "", description: item.description, link: item.link)

        if UIDevice.type == .iPhone, let detailViewController = self.detailViewController {
            navigationController?.pushViewController(detailViewController, animated: true)
            #warning("Do in Coordinator")
        }
    }

    // MARK: UICOLLECTIONVIEWDELEGATEFLOWLAYOUT

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.size.width - (interItemSpacing * 2), height: view.frame.size.height * 0.3)
    }
}
