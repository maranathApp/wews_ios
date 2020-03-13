//
//  ErrorViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/11/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import Combine

final class ErrorViewModel {

    // MARK: - INTERNAL ATTRIBUTES

    @Published var title: String?

    let reloadAction: () -> Void

    // MARK: - INITIALIZERS

    init(title: String, reloadAction: @escaping () -> Void) {
        self.title = title
        self.reloadAction = reloadAction
    }
}
