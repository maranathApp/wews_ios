//
//  DetailViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/13/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Core
import Combine
import UIComponentKit

final class DetailViewModel: ViewModelling, ObservableObject {

    // MARK: - INTERNAL ATTRIBUTES

    @Published var title: String?
    @Published var description: String?
    @Published var link: URL?

    // MARK: - INITIALIZERS

    init() {}

    // MARK: - INTERNAL METHODS

    func setUp(with title: String, description: String, link: URL?) {
        self.title = title
        self.description = description
        self.link = link
    }
}
