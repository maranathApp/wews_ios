//
//  ParameterEncoding.swift
//  NetworkKit
//
//  Created by MaranathApp on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation

#warning("To be tested")
public enum ParameterEncoding {
    case url
    case urlEncodedInURL
    case json

    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    /// - Parameters:
    ///   - request: URLrequest
    ///   - parameters: parameters of the request
    func encode(request: URLRequest, parameters: [String: Any]?) throws -> URLRequest {
        guard let parameters = parameters else { return request }

        var request = request

        var encodingError: NSError?

        switch self {
        case .url, .urlEncodedInURL:
            if let httpMethod = request.httpMethod, let method = HttpMethod(rawValue: httpMethod), encodesParametersInURL(method: method) {
                if let URLComponents = NSURLComponents(url: request.url!, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                    let percentEncodedQuery = (URLComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + UrlEncoder.query(parameters: parameters)
                    URLComponents.percentEncodedQuery = percentEncodedQuery
                    request.url = URLComponents.url
                }
            } else {
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }

                request.httpBody = UrlEncoder.query(parameters: parameters).data(using: String.Encoding.utf8, allowLossyConversion: false)
            }
        case .json:
            do {
                let options = JSONSerialization.WritingOptions()
                let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }

                request.httpBody = data
            } catch {
                encodingError = error as NSError
            }
        }

        guard encodingError == nil else { throw encodingError! }

        return request
    }

    private func encodesParametersInURL(method: HttpMethod) -> Bool {
        switch self {
        case .urlEncodedInURL:
            return true
        default:
            break
        }

        switch method {
        case .GET, .DELETE:
            return true
        default:
            return false
        }
    }
}
