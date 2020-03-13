//
//  EndPoint.swift
//  NetworkKit
//
//  Created by Frezy VAMBE on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case GET
    case PUT
    case DELETE
    case POST
}

public protocol Endpoint {
    /// Base url for the current endPoint. Can be specifed for all routes in the extension, and/or seperatly for each route
    var baseURLString: String { get }

    /// HTTP request method to be used for this endPoint
    var method: HttpMethod { get }

    /// The url path for this endPoint
    var path: String { get }

    /// Use this if you need to build a request with both query string and JSON parameters
    var queryStringParameters: [String: Any]? { get }

    /// The request parameters for current endPoint
    var parameters: [String: Any]? { get }

    /// Parameter encoding for current endPoint
    var encoding: ParameterEncoding { get }

    /// The request headers for the current endPoint
    var headers: [String: String]? { get }

    /// Closure that checks response status code and returns response or throw error
    ///
    /// Default closure returns response if :
    /// - status code ~= 200-299
    /// and errors otherwise
    var httpCodeValidator: ((Data, URLResponse) throws -> Bool) { get }

    /// Closure that checks response body and returns response or throw error
    ///
    /// Default closure returns true
    var businessValidator: ((Data, URLResponse) throws -> Bool) { get }

    /// Function creating UrlRequest with endPoint information
    ///
    /// Default implementation creates UrlRequest with endPoint data
    func createRequest() throws -> URLRequest
}

extension Endpoint {
    public var httpCodeValidator: ((Data, URLResponse) throws -> Bool) {
        return { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw GenericError.unknownResponse
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                if 400..<500 ~= httpResponse.statusCode {
                    throw HttpError.access
                } else if 500..<600 ~= httpResponse.statusCode {
                    throw HttpError.internal
                } else {
                    throw HttpError.unknownCode
                }
            }

            return true
        }
    }

    public var businessValidator: ((Data, URLResponse) throws -> Bool) {
        return { data, response in
            return true
        }
    }

    public func createRequest() throws -> URLRequest {
        guard var url = URL(string: baseURLString) else { throw RequestError.invalidBaseUrlString }

        if !path.isEmpty {
            url.appendPathComponent(path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        for (key, value) in headers ?? [:] {
            request.addValue(value, forHTTPHeaderField: key)
        }

        return try encoding.encode(request: request, parameters: parameters)
    }
}
