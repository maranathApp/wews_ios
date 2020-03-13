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
        static var master: MasterViewController {
            return MasterViewController(viewModel: MasterViewModel(inputs: MasterViewModelInputs(RSSFeedService: ServicesProvider.RSSFeed.service)))
        }

        static var detail: DetailViewController {
            return DetailViewController(viewModel: DetailViewModel())
        }

        static func web(with viewModel: WebViewModel) -> WebViewController {
            return WebViewController(viewModel: viewModel)
        }
    }
}
