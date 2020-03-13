//
//  Errors.swift
//  NetworkKit
//
//  Created by Frezy VAMBE on 3/05/2020.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation

public enum HttpError: Error {
    case `internal`
    case access
    case unknownCode
}

public enum GenericError: Error {
    case unknownResponse
    case empty
}

public enum RequestError: Error {
    case invalidBaseUrlString
}
