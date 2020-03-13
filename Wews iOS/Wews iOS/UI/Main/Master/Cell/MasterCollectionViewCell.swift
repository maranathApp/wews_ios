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

    @IBOutlet weak var imageView: LoadingImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - ATTRIBUTES

    private var cancellables = Set<AnyCancellable>()

    // MARK: - LIFE CYCLE METHODS

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.reuse()
        cancellables.removeAll()
    }

    // MARK: - METHODS

    func setup(with viewModel: SetupModel) {
        viewModel
            .$imageURL
            .assign(to: \.imageURL, on: imageView)
            .store(in: &cancellables)

        viewModel
            .$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)
    }
}
