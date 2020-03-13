//
//  DetailViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import Core
import Combine
import UIComponentKit

final class DetailViewModel: ViewModelling, ObservableObject {

    // MARK: - INTERNAL ATTRIBUTES

    @Published var title: String?
    @Published var description: String?
    @Published var imageURL: URL?
    @Published var readArticleTitle: String?
    @Published var unselectedCellTitle: String?

    var link: URL?

    var cancellables = Set<AnyCancellable>()

    // MARK: - INITIALIZERS

    init() {
        self.readArticleTitle = "master.readArticle.buttonTitle".localized
        self.unselectedCellTitle = "detail.unselectedCell.title".localized
    }

    // MARK: - INTERNAL METHODS

    func setUp(with title: String, imageURL: URL?, description: String, link: URL?) {
        self.title = title
        self.imageURL = imageURL
        self.link = link
        self.description = description
    }

    func getWebViewModel() -> WebViewModel {
        return WebViewModel(title: title ?? "", link: link)
    }
}
