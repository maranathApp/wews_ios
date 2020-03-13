//
//  RSSTests.swift
//  CoreTests
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import XCTest
@testable import Core

final class RSSTests: XCTestCase {
    var sut: RSS?
    var channel: Channel!

    // MARK: - Channel dummy data

    let channelTitle = "Le Monde.fr - Actualités et Infos en France et dans le monde"
    let channelDescription = "Le Monde.fr - 1er site d’information. Les articles du journal et toute l’actualité en continu : International, France, Société, Economie, Culture, Environnement, Blogs ..."
    let channelCopyright = "Le Monde - L’utilisation des flux RSS du Monde.fr est réservée à un usage strictement personnel, non professionnel et non collectif. Toute autre exploitation doit faire l’objet d’une autorisation et donner lieu au versement d’une rémunération. Contact : droitsdauteur@lemonde.fr"

    // MARK: - Pre and Post setups during test

    override func setUp() {
        // GIVEN
        channel = Channel(title: channelTitle, description: channelDescription, copyright: channelCopyright, items: [])
        sut = RSS(channel: channel)
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
        let dummyObject = RSS(channel: channel)
        // THEN
        XCTAssertEqual(sut, dummyObject)
    }

    func testChannelPropertyIsValid() {
        // WHEN
        // THEN
        XCTAssertEqual(sut?.channel, channel)
    }
}
