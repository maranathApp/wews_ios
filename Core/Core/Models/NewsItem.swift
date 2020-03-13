//
//  NewsItem.swift
//  Core
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation

public struct NewsItem: Codable, Equatable {

    enum CodingKeys: String, CodingKey {
        case title, pubDate, description, link
        case mediaContent = "media:content"
    }

    // MARK: - PUBLIC ATTRIBUTES

    public let title: String
    public let pubDate, description, link: String
    public let mediaContent: MediaContent
}
