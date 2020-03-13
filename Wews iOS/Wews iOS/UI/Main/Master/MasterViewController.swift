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

protocol MasterViewControllerDelegate: class {
    func didPresentDetailViewController(_ vc: MasterViewController, detailViewModel: DetailViewModel)
}

final class MasterViewController: CollectionViewController<MasterCollectionViewCell, MasterViewModel> {

    // MARK: - PRIVATE ATTRIBUTES

    private var detailViewController: DetailViewController?

    private let interItemSpacing: CGFloat = 16
    private let edgeSpacingInset: CGFloat = 8

    private lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    private var stateView: UIView?

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

    private lazy var loadingView: LoadingView = {
        let view = LoadingView.loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var emptyView: EmptyView = {
        let view = EmptyView.loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var errorView: ErrorView = {
        let view = ErrorView.loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - INTERNAL ATTRIBUTES

    weak var delegate: MasterViewControllerDelegate?

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
        }

        viewModel.loadData()
    }

    private func bindViewModel() {
        viewModel
            .$viewState
            .map({ $0.unsafelyUnwrapped })
            .sink { [weak self] state in
                self?.handle(state: state)
        }
        .store(in: &viewModel.cancellables)
    }

    private func handle(state: ViewState) {

        switch state {
        case .data:
            stateView?.removeFromSuperview()
            collectionView?.reloadData()
            stateView = nil
        case .loading:
            stateView = loadingView
        case .empty:
            emptyView.setup(with: EmptyViewModel(title: viewModel.noDataMessage, reloadAction: viewModel.loadData))
            stateView = emptyView
        case .error(let error):
            notificationFeedbackGenerator.notificationOccurred(.error)
            if let reachabilityError = error as? ReachabilityError {
                switch reachabilityError {
                case .noNetwork:
                    errorView.setup(with: ErrorViewModel(title: viewModel.noNetworkMessage, reloadAction: viewModel.loadData))
                default:
                    errorView.setup(with: ErrorViewModel(title: error.localizedDescription, reloadAction: viewModel.loadData))
                }
            } else {
                errorView.setup(with: ErrorViewModel(title: error.localizedDescription, reloadAction: viewModel.loadData))
            }
            stateView = errorView
        }

        guard let stateView = self.stateView else  {
            self.stateView?.removeFromSuperview()
            
            return
        }

        view.insertSubview(stateView, aboveSubview: view)
        NSLayoutConstraint.activate([
            stateView.topAnchor.constraint(equalTo: view.topAnchor),
            stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stateView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stateView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }

    private func presentAlertController(title: String, message: String, cancelActionTitle: String, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel, handler: cancelHandler))
        present(alertController, animated: true)
    }

    // MARK: UICOLLECTIONVIEWDELEGATE

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.hasNetwork else {
            notificationFeedbackGenerator.notificationOccurred(.error)

            return presentAlertController(title: viewModel.alertTitle, message: viewModel.noNetworkMessage, cancelActionTitle: viewModel.alertOkayButtonTitle)
        }

        delegate?.didPresentDetailViewController(self, detailViewModel: viewModel.getDetailViewModel(for: indexPath))
    }

    // MARK: UICOLLECTIONVIEWDELEGATEFLOWLAYOUT

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.size.width - (interItemSpacing * 2), height: view.frame.size.height * 0.3)
    }
}
