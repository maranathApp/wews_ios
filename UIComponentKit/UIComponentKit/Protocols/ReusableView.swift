//
//  ReusableView.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2018 MaranathApp. All rights reserved.
//

import Foundation

public protocol ReusableView {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
