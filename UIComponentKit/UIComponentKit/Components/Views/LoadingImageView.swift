//
//  LoadingImageView.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/12/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit.UIImageView
import UIKit.UIActivityIndicatorView

private let imageCache = NSCache<NSString, UIImage>()

public class LoadingImageView: UIImageView {

    // MARK: - PRIVATE ATTRIBUTES

    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true

        return view
    }()

    // MARK: - PUBLIC ATTRIBUTES

    public var imageURL: URL? {
        didSet {
            if imageURL != nil {
                load()
            }
        }
    }

    // MARK: - INITIALIZERS

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    // MARK: - PRIVATE METHODS

    fileprivate func setup() {
        backgroundColor = .lightGray
        addSubview(indicatorView)

        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 45),
            indicatorView.widthAnchor.constraint(equalToConstant: 45),
        ])
    }

    // MARK: - PUBLIC METHODS

    public func reuse() {
        image = nil
        indicatorView.stopAnimating()
    }

    public func load() {
        indicatorView.startAnimating()

        guard let url = imageURL, imageCache.object(forKey: url.absoluteString as NSString) == nil else {
            DispatchQueue.main.async { [weak self] in
                if case let strongSelf? = self {
                    strongSelf.indicatorView.stopAnimating()
                    strongSelf.image = imageCache.object(forKey: (strongSelf.imageURL?.absoluteString ?? "") as NSString)
                }
            }

            return
        }

        image = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if error != nil {
                self?.indicatorView.stopAnimating()
                self?.image = UIImage(named: "placeholder.error.jpg")
            } else {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data.unsafelyUnwrapped) {
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        self?.indicatorView.stopAnimating()
                        self?.image = imageToCache
                    } else {
                        self?.indicatorView.stopAnimating()
                        self?.image = UIImage(named: "placeholder.error.jpg")
                    }
                }
            }
        }.resume()
    }


}
