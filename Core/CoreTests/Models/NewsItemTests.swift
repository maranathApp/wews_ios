//
//  NewsItemTests.swift
//  CoreTests
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest
@testable import Core

class NewsItemTests: XCTestCase {

    var sut: NewsItem?

    // MARK: - Dummy data

    let title = "Municipales et coronavirus : « Plus le temps passe et moins le report est possible »"
    let pubDate = "Thu, 05 Mar 2020 18:18:27 +0100"
    let _description = "Possible en droit, qu’elle soit ciblée ou nationale, l’éventualité d’un report des élections municipales a de nouveau été rejetée, cette semaine, par le gouvernement."
    let link = "https://www.lemonde.fr/politique/article/2020/03/05/municipales-et-coronavirus-plus-le-temps-passe-et-moins-le-report-est-possible_6031974_823448.html"
    let mediaContentURLString =  "https://www.lemonde.fr/politique/article/2020/03/05/municipales-et-coronavirus-plus-le-temps-passe-et-moins-le-report-est-possible_6031974_823448.html"

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        sut = NewsItem(title: title, pubDate: pubDate, description: _description, link: link, mediaContent: MediaContent(url: mediaContentURLString))
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
        let dummyObject = NewsItem(title: title, pubDate: pubDate, description: _description, link: link, mediaContent: MediaContent(url: mediaContentURLString))
        // THEN
        XCTAssertEqual(sut, dummyObject)
    }

    func testTitlePropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.title, title)
    }

    func testPubDatePropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.pubDate, pubDate)
    }

    func testDescriptionPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.description, _description)
    }

    func testLinkPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.link, link)
    }

    func testMediaContentPropertyIsValid() {
        // WHEN
        let dummyObject = MediaContent(url: mediaContentURLString)

        // THEN
        XCTAssertEqual(sut?.mediaContent, dummyObject)
    }

}
