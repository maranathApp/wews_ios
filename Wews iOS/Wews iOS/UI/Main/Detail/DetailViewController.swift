//
//  DetailViewController.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit
import UIComponentKit
import Combine

protocol DetailViewControllerDelegate: class {
    func didPresentWebViewController(_ vc: DetailViewController, with webViewModel: WebViewModel)
}

final class DetailViewController: ViewController<DetailViewModel> {

    // MARK: - PRIVATE ATTRINUTES

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let imageView: LoadingImageView = {
        let view = LoadingImageView(frame: CGRect.zero)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5

        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }()

    private let descriptionTextView: UITextView = {
        let view = UITextView()
        view.dataDetectorTypes = [.address, .link, .phoneNumber]
        view.textColor = .darkGray
        view.isEditable = false
        view.backgroundColor = .clear
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let readArticleButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentWebViewController), for: .touchUpInside)

        return button
    }()

    private lazy var emptyView: EmptyView = {
        let view = EmptyView.loadNib()
        view.reloadButton.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - INTERNAL ATTRIBUTES

    weak var delegate: DetailViewControllerDelegate?

    // MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }

    // MARK: - PRIVATE METHODS

    private func setUpUI() {
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        [imageView, titleLabel, descriptionTextView].forEach(stackView.addArrangedSubview)
        view.addSubview(readArticleButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            readArticleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            readArticleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            readArticleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            readArticleButton.heightAnchor.constraint(equalToConstant: 45),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            stackView.bottomAnchor.constraint(equalTo: readArticleButton.topAnchor, constant: -6),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6)
        ])
    }

    private func bindViewModel() {
        viewModel
            .$title
            .assign(to: \.title, on: navigationItem)
            .store(in: &viewModel.cancellables)

        viewModel
            .$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &viewModel.cancellables)

        viewModel
            .$description
            .assign(to: \.text, on: descriptionTextView)
            .store(in: &viewModel.cancellables)

        viewModel
            .$imageURL
            .assign(to: \.imageURL, on: imageView)
            .store(in: &viewModel.cancellables)

        viewModel
            .$readArticleTitle
            .assign(to: \.titleForNormalState, on: readArticleButton)
            .store(in: &viewModel.cancellables)

        viewModel
            .$unselectedCellTitle
            .assign(to: \.text, on: emptyView.titleLabel)
            .store(in: &viewModel.cancellables)

        viewModel
            .$title
            .map({ $0 == nil ? true : false })
            .sink { [weak self] isHidden in
                self?.stackView.isHidden = isHidden
                self?.readArticleButton.isHidden = isHidden
                self?.showEmptyView(isHidden)
        }
        .store(in: &viewModel.cancellables)
    }

    @objc private func presentWebViewController() {
        delegate?.didPresentWebViewController(self, with: viewModel.getWebViewModel())
    }

    private func showEmptyView(_ shouldShow: Bool) {
        if shouldShow {
            view.insertSubview(emptyView, aboveSubview: view)
            NSLayoutConstraint.activate([
                emptyView.topAnchor.constraint(equalTo: view.topAnchor),
                emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                emptyView.leftAnchor.constraint(equalTo: view.leftAnchor),
                emptyView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        } else {
            emptyView.removeFromSuperview()
        }
    }
}
