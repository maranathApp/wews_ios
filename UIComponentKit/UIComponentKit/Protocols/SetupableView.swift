//
//  SetupableView.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit.UIView

public protocol SetupableView where Self: UIView {
    associatedtype SetupModel
    func setup(with setupModel: SetupModel)
}
