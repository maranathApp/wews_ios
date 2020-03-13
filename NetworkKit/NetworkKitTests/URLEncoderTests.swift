//
//  URLEncoderTests.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest
@testable import NetworkKit

class URLEncoderTests: XCTestCase {

    // MARK: - Testing methods

    func testQueryMethods() {
        // GIVEN
        let parameters: [String: Any] = ["maxNumber": 18, "page": "4"] as [String : Any]
        // WHEN
        let result = UrlEncoder.query(parameters: parameters)
        // THEN
        XCTAssertEqual(result, "maxNumber=18&page=4")
    }
}

