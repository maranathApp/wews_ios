//
//  ErrorView.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/11/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit.UIView
import UIComponentKit
import Combine

final class ErrorView: UIView, SetupableView {

    typealias SetupModel = ErrorViewModel

    // MARK: - PRIVATE ATTRIBUTES

    private var setupModel: ErrorViewModel?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - @IBOUTLETS

    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - INTERNAL METHODS

    func setup(with setupModel: ErrorViewModel) {
        self.setupModel = setupModel

        self.setupModel?
            .$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)
    }

    // MARK: - @IBACTIONS

    @IBAction func reloadAction(_ sender: UIButton) {
        setupModel?.reloadAction()
    }

}
