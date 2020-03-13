//
//  MockedDataFetcherTests.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest

class MockedDataFetcherTests: XCTestCase {

    var sut: MockedDataFetcher?
    let mockedEndpoint = MockedEndpoint()

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        sut = MockedDataFetcher()
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

    func testRequestMethodHasBeenCalled() {
        // WHEN
        do {
            // THEN
            _ = try sut?.request(endPoint: mockedEndpoint)
            XCTAssertTrue(sut!.requestMethodHasBeenCalled)
        } catch {}
    }

    func testRequestMethodCreateSuccessfulURLRequest() {
        // WHEN
        do {
            _ = try sut?.request(endPoint: mockedEndpoint)
            // THEN
            XCTAssertNotNil(sut?.request)
        } catch {}
    }

    func testRequestMethodDoesNotThrow() {
        // WHEN
        // THEN
        XCTAssertNoThrow(try sut?.request(endPoint: mockedEndpoint))

    }
}
