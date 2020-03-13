//
//  MediaContentTests.swift
//  CoreTests
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest
@testable import Core

class MediaContentTests: XCTestCase {

    var sut: MediaContent?

    let mediaContentURLString =  "https://www.lemonde.fr/politique/article/2020/03/05/municipales-et-coronavirus-plus-le-temps-passe-et-moins-le-report-est-possible_6031974_823448.html"

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        sut = MediaContent(url: mediaContentURLString)
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
        let dummyObject = MediaContent(url: mediaContentURLString)
        // THEN
        XCTAssertEqual(sut, dummyObject)
    }

    func testURLPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.url, mediaContentURLString)
    }
}
