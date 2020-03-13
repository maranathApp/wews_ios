//
//  ViewController.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit

open class ViewController<ViewModel: ViewModelling>: UIViewController {

    // MARK: - PUBLIC ATTRIBUTES

    public var viewModel: ViewModel!

    // MARK: - PUBLIC INITIALIZERS

    public init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        preconditionFailure("Tried to instantiate \(name) from nib.")
    }

    #if DEBUG
    deinit {
        print(String(describing: self) + " has been deinitialized.")
    }
    #endif
}
