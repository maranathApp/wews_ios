//
//  ViewModelProvider+Main.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Core

extension ViewModelProvider {
    enum Main {
        static var masterViewModel: MasterViewModel {
            return MasterViewModel(inputs: MasterViewModelInputs(RSSFeedService: ServicesProvider.RSSFeed.service))
        }

        static var detailViewModel: DetailViewModel {
            return DetailViewModel()
        }
    }
}
