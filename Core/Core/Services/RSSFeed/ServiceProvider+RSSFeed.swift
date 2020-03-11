//
//  ServiceProvider+RSSFeed.swift
//  Core
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import NetworkKit

extension ServicesProvider {
    public enum RSSFeed {
        public static var service: RSSFeedServicing {
            return RSSFeedService(dataFetcher: WebDataFetcher(urlSession: URLSession(configuration: .default)))
        }
    }
}
