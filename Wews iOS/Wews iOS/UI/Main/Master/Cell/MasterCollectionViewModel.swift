//
//  MasterCollectionViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Combine

final class MasterCollectionViewModel {

    // MARK: - INTERNAL ATTRIBUTES

    @Published var title: String?
    @Published var imageURL: URL?

    let description: String
    let link: URL?

    // MARK: - INITIALIZERS

    init(title: String, description: String, link: URL?, imageURL: URL?) {
        self.title = title
        self.imageURL = imageURL
        self.description = description
        self.link = link
    }
}
