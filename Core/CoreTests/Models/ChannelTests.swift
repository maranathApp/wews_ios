//
//  ChannelTests.swift
//  CoreTests
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest
@testable import Core

class ChannelTests: XCTestCase {
    var sut: Channel?
    var items = [NewsItem]()

    // MARK: - Channel dummy data

    let channelTitle = "Le Monde.fr - Actualités et Infos en France et dans le monde"
    let channelDescription = "Le Monde.fr - 1er site d’information. Les articles du journal et toute l’actualité en continu : International, France, Société, Economie, Culture, Environnement, Blogs ..."
    let channelCopyright = "Le Monde - L’utilisation des flux RSS du Monde.fr est réservée à un usage strictement personnel, non professionnel et non collectif. Toute autre exploitation doit faire l’objet d’une autorisation et donner lieu au versement d’une rémunération. Contact : droitsdauteur@lemonde.fr"

    // MARK: - NewsItem dummy data

    let title = "Municipales et coronavirus : « Plus le temps passe et moins le report est possible »"
    let pubDate = "Thu, 05 Mar 2020 18:18:27 +0100"
    let _description = "Possible en droit, qu’elle soit ciblée ou nationale, l’éventualité d’un report des élections municipales a de nouveau été rejetée, cette semaine, par le gouvernement."
    let link = "https://www.lemonde.fr/politique/article/2020/03/05/municipales-et-coronavirus-plus-le-temps-passe-et-moins-le-report-est-possible_6031974_823448.html"
    let mediaContentURLString =  "https://www.lemonde.fr/politique/article/2020/03/05/municipales-et-coronavirus-plus-le-temps-passe-et-moins-le-report-est-possible_6031974_823448.html"

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        items.append(NewsItem(title: title, pubDate: pubDate, description: _description, link: link, mediaContent: MediaContent(url: mediaContentURLString)))
        sut = Channel(title: channelTitle, description: channelDescription, copyright: channelCopyright, items: items)
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
        let dummyObject = Channel(title: channelTitle, description: channelDescription, copyright: channelCopyright, items: items)
        // THEN
        XCTAssertEqual(sut, dummyObject)
    }

    func testTitlePropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.title, channelTitle)
    }

    func testCopyrightPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.copyright, channelCopyright)
    }

    func testDescriptionPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.description, channelDescription)
    }

    func testItemsPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.items, items)
    }

    func testCountInItemsArrayIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.items.count, 1)
    }

}
