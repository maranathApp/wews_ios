//
//  MockedServiceTests.swift
//  NetworkKitTests
//
//  Created by Frezy Mboumba on 3/13/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest

class MockedServiceTests: XCTestCase {

    var sut: MockedService?
    let mockedEnpoint = MockedEndpoint()
    let mockedDataFetcher = MockedDataFetcher()

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        sut = MockedService(dataFetcher: mockedDataFetcher)
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

    func testDataFetcherIsNotNil() {
        // WHEN
        // THEN
        XCTAssertNotNil(sut?.dataFetcher)
    }

    func testTryXMLRequestMethodHasBeenCalled() {
        // WHEN
        _ = sut?.callXML(mockedEndpoint: mockedEnpoint)
        // THEN
        XCTAssertTrue(sut!.tryXMLRequestMethodHasBeenCalled)
    }

    func testTryJSONRequestMethodHasBeenCalled() {
        // WHEN
        _ = sut?.callJSON(mockedEndpoint: mockedEnpoint)
        // THEN
        XCTAssertTrue(sut!.tryJSONRequestMethodHasBeenCalled)
    }

}
