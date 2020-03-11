//
//  NibLoadable.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit.UIView

public protocol NibLoadable {
     static func loadNib() -> Self
}

public extension NibLoadable where Self: UIView {
    static func loadNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? Self else {
            preconditionFailure("Failed to load View \(Self.nibName)")
        }

        return nib
    }
}
