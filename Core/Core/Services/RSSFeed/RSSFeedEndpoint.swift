//
//  RSSFeedEndpoint.swift
//  CoreServices
//
//  Created by Frezy Mboumba on 3/9/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import Foundation
import NetworkKit

struct RSSFeedEndpoint: Endpoint {

    // MARK: - INTERNAL ATTRIBUTES
    
    let parameter: RSSFeedServiceParameter
    var baseURLString: String { "https://www.lemonde.fr/rss/une.xml" }
    var method: HttpMethod { .GET }
    var path: String { "" }
    var queryStringParameters: [String : Any]? { nil }
    var parameters: [String: Any]? { nil }
    var headers: [String: String]? { nil}
    var encoding: ParameterEncoding { .urlEncodedInURL }
}
