//
//  MockedEndpoint.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/12/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
@testable import NetworkKit

final class MockedEndpoint: Endpoint, Equatable {
    static func == (lhs: MockedEndpoint, rhs: MockedEndpoint) -> Bool {
        return lhs.baseURLString == rhs.baseURLString &&
            lhs.method == rhs.method &&
            lhs.path == rhs.path &&
            lhs.encoding == rhs.encoding &&
            lhs.headers == rhs.headers
    }

    var baseURLString: String { "https://instant-system.com" }

    var method: HttpMethod { .POST }

    var path: String { "/iOS" }

    var queryStringParameters: [String : Any]?

    var parameters: [String : Any]?

    var encoding: ParameterEncoding { .json }

    var headers: [String : String]?
}
