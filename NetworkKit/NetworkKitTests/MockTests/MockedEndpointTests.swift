//
//  MockedEndpointTests.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest

class MockedEndpointTests: XCTestCase {

    var sut: MockedEndpoint?
    let dummyEndpoint = MockedEndpoint()

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        sut = MockedEndpoint()
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Testing methods

    func testSutIsNotNil() {
        // WHEN
        // THEN
        XCTAssertNotNil(sut)
    }

    func testSutIsValid() {
        // WHEN
        let dummyObject = MockedEndpoint()
        // THEN
        XCTAssertEqual(sut, dummyObject)
    }

    func testBaseURStringLPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.baseURLString, dummyEndpoint.baseURLString)
    }

    func testPathPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.path, dummyEndpoint.path)
    }

    func testEncodingPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.encoding, dummyEndpoint.encoding)
    }

    func testParametersPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertNil(sut?.parameters)
    }

    func testHeadersPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.headers, dummyEndpoint.headers)
    }

    func testQueryStringParametersPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertNil(sut?.queryStringParameters)
    }

    func testHTTPMethodPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.method, dummyEndpoint.method)
    }
}
