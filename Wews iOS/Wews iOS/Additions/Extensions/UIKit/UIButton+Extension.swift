//
//  UIButton+Extension.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    var titleForNormalState: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
}
