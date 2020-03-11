//
//  MasterCollectionViewCell.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit
import UIComponentKit
import Combine

final class MasterCollectionViewCell: UICollectionViewCell, SetupableView {
    typealias SetupModel = MasterCollectionViewModel

    // MARK: - @IBOUTLETS

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    // MARK: - ATTRIBUTES

    private var cancellables = Set<AnyCancellable>()

    // MARK: - LIFE CYCLE METHODS

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        indicatorView.startAnimating()
        cancellables.removeAll()
    }

    // MARK: - METHODS

    func setup(with viewModel: SetupModel) {
        imageView.load(from: viewModel.imageURL) { [weak self] error in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                if error != nil {
                    self?.imageView.image = UIImage(named: "placeholder.error")
                }
            }
        }
        
        viewModel
            .$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)

    }
}
