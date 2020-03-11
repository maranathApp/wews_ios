//
//  Servicing.swift
//  NetworkKit
//
//  Created by MaranathApp on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import Combine

#warning("To be tested")
public protocol Servicing {
    init(dataFetcher: DataFetcher)
    var dataFetcher: DataFetcher { get }
}

public extension Servicing {
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }

    private var xmlDecoder: XMLDecoder {
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }

    private  var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.dataEncodingStrategy = .custom({ data, encoder in
            let str: String
            if let decoded = String(data: data, encoding: .utf8) {
                str = decoded
            } else {
                str = data.base64EncodedString()
            }
            var container = encoder.singleValueContainer()
            try container.encode(str)
        })

        return encoder
    }

    #warning("To be tested")
    /// Requesting data through dataFetcher for a given endpoint using JSONDecoder
    /// - Parameter endPoint: given endpoint
    func tryJSONRequest<T: Decodable>(endPoint: Endpoint) -> AnyPublisher<T, Error> {
        do {
            return try dataFetcher.request(endPoint: endPoint)
                .map(\.data)
                .decode(type: T.self, decoder: jsonDecoder)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(outputType: T.self, failure: error).eraseToAnyPublisher()
        }
    }

    #warning("To be tested")
    /// Requesting data through dataFetcher for a given endpoint using XMLDecoder
    /// - Parameter endPoint: given endpoint
    func tryXMLRequest<T: Decodable>(endPoint: Endpoint) -> AnyPublisher<T, Error> {
        do {
            return try dataFetcher.request(endPoint: endPoint)
                .map(\.data)
                .map({ data -> Data in
                    guard let stringifiedData = String(data: data, encoding: .utf8) else {
                        return data
                    }

                    return stringifiedData
                    .replacingOccurrences(of: "<![CDATA[", with: "")
                    .replacingOccurrences(of: "]]>", with: "")
                    .data(using: .utf8)
                    .unsafelyUnwrapped
                })
                .decode(type: T.self, decoder: xmlDecoder)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(outputType: T.self, failure: error).eraseToAnyPublisher()
        }
    }
}
