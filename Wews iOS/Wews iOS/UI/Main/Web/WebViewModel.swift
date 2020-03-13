//
//  WebViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/13/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Core
import Combine
import UIComponentKit

final class WebViewModel: ViewModelling, ObservableObject {

    // MARK: - INTERNAL ATTRIBUTES

    @Published var title: String?
    @Published var link: URL?

    @Published var closeTitle: String?

    var cancellables = Set<AnyCancellable>()

    // MARK: - INITIALIZERS

    init(title: String, link: URL?) {
        self.title = title
        self.link = link
        self.closeTitle = "common.close".localized
    }
}
