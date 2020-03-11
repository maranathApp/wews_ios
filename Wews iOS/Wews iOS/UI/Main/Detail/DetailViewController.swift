//
//  DetailViewController.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit
import UIComponentKit
import WebKit
import Combine

final class DetailViewController: ViewController<DetailViewModel> {

    enum WKWebViewKeyPath: String {
        case estimatedProgress
    }

    // MARK: - PRIVATE ATTRIBUTES

    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - INTERNAL ATTRIBUTES

    var cancellables = Set<AnyCancellable>()

    // MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        removeObservers()
    }

    // MARK: - PRIVATE METHODS

    private func setUpUI() {
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.addSubview(progressView)
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 5),
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    private func bindViewModel() {
        viewModel
            .$title
            .assign(to: \.title, on: navigationItem)
            .store(in: &cancellables)

        viewModel
            .$link
            .filter({ $0 != nil })
            .map({ $0.unsafelyUnwrapped })
            .sink { [weak webView] link in
                webView?.load(URLRequest(url: link))
            }
            .store(in: &cancellables)
    }

    private func addObservers() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    private func removeObservers() {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

    // MARK: - INTERNAL METHODS

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch WKWebViewKeyPath(rawValue: "estimatedProgress") ?? .none {
        case .estimatedProgress:
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                let progress = Float(strongSelf.webView.estimatedProgress)
                strongSelf.progressView.progress = progress
                strongSelf.progressView.isHidden = progress == 1.0 ? true : false
            }
        case .none: break
        }
    }

}
