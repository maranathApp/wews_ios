//
//  UIView+Extension.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit.UIView

#warning("To be tested")
extension UIView: NibLoadable, ReusableView {
    var name: String {
        return String(describing: self)
    }
}
