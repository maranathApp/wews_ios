//
//  Channel.swift
//  CoreModels
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation

public struct Channel: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case title, description, copyright
        case items = "item"
    }

    // MARK: - PUBLIC ATTRIBUTES

    public let title, description, copyright: String
    public let items: [NewsItem]
}
