//
//  String+Extension.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/12/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "") }
}
