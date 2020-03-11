//
//  WebDataFetcher.swift
//  NetworkKit
//
//  Created by MaranathApp on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Combine

public class WebDataFetcher: DataFetcher {
    let urlSession: URLSession

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func request(endPoint: Endpoint) throws -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        let request = try endPoint.createRequest()
        let backgroundQueue = DispatchQueue(label: "wews.backgroundQueue.\(endPoint.baseURLString).\(endPoint.path)")

        return urlSession.dataTaskPublisher(for: request)
            .tryFilter(endPoint.httpCodeValidator)
            .tryFilter(endPoint.businessValidator)
            .subscribe(on: backgroundQueue)
            .eraseToAnyPublisher()
    }
}
