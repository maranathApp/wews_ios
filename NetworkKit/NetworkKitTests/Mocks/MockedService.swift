//
//  MockedService.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/12/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import Combine
@testable import NetworkKit

protocol MockedServicing {
    func callJSON(mockedEndpoint: MockedEndpoint) -> AnyPublisher<String, Error>
    func callXML(mockedEndpoint: MockedEndpoint) -> AnyPublisher<String, Error>
}

final class MockedService: Servicing, MockedServicing {

    // MARK: - INTERNAL ATTRIBUTES

    let dataFetcher: DataFetcher

    var tryXMLRequestMethodHasBeenCalled = false
    var tryJSONRequestMethodHasBeenCalled = false

    // MARK: - INITIALIZERS

    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
    }

    // MARK: - PUBLIC METHODS

    func callJSON(mockedEndpoint: MockedEndpoint) -> AnyPublisher<String, Error> {
        tryXMLRequestMethodHasBeenCalled = true

        return tryXMLRequest(endPoint: mockedEndpoint)
    }

    func callXML(mockedEndpoint: MockedEndpoint) -> AnyPublisher<String, Error> {
        tryJSONRequestMethodHasBeenCalled = true

        return tryJSONRequest(endPoint: mockedEndpoint)
    }
}
