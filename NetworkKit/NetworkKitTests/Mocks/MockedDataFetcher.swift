//
//  MockedDataFetcher.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/12/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import Combine
@testable import NetworkKit

final class MockedDataFetcher: DataFetcher {

    enum MockedDataFetcherError: Error {
        case failedToBuildURL
    }

    // MARK: - INTERNAL ATTRIBUTES

    var request: URLRequest?
    var requestMethodHasBeenCalled = false

    // MARK: - INTERNAL METHODS
 
    func request(endPoint: Endpoint) throws -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        request = try endPoint.createRequest()
        requestMethodHasBeenCalled = true

        guard let url = request?.url else  {
            return Future<(data: Data, response: URLResponse), Error> { promise in
                promise(.failure(MockedDataFetcherError.failedToBuildURL))
            }.eraseToAnyPublisher()
        }

        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let data = Data()

        return Just<(data: Data, response: URLResponse)>.init((data, urlResponse))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}
