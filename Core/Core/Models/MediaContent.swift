//
//  MediaContent.swift
//  Core
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation

public struct MediaContent: Codable, Equatable {

    enum CodingKeys: String, CodingKey {
        case url
    }

    // MARK: - PUBLIC ATTRIBUTES

    public let url: String
}
