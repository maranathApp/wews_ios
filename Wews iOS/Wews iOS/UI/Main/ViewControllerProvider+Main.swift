//
//  ViewControllerProvider+Main.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Core

extension ViewControllerProvider {
    enum Main {
        static var master: MasterViewController { MasterViewController(viewModel: ViewModelProvider.Main.masterViewModel) }
        static var detail: DetailViewController { DetailViewController(viewModel: ViewModelProvider.Main.detailViewModel) }
    }
}
