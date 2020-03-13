//
//  DataFetcher.swift
//  NetworkKit
//
//  Created by Frezy VAMBE on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Combine

public protocol DataFetcher {
    func request(endPoint: Endpoint) throws -> AnyPublisher<(data: Data, response: URLResponse), Error>
}
