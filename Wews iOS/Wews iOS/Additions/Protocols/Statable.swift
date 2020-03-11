//
//  Statable.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/10/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation

enum ViewState {
    case error(Error)
    case data
    case empty
}

protocol Statable {
    var viewState: ViewState { get }
}
