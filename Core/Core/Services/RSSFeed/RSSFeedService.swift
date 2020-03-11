//
//  RSSFeedService.swift
//  CoreServices
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import NetworkKit
import Combine

#warning("To be tested")
public protocol RSSFeedServicing {
    func call(parameter: RSSFeedServiceParameter) -> AnyPublisher<RSS, Error>
}

final class RSSFeedService: Servicing, RSSFeedServicing {

    // MARK: - INTERNAL ATTRIBUTES

    let dataFetcher: DataFetcher

    // MARK: - INTERNAL INITIALIZER

    required init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
    }

    // MARK: - PUBLIC METHODS

    public func call(parameter: RSSFeedServiceParameter) -> AnyPublisher<RSS, Error> {
        tryXMLRequest(endPoint: RSSFeedEndpoint(parameter: parameter))
    }
}
