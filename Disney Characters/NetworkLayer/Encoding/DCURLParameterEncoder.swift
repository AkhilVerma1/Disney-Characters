//
//  DCURLParameterEncoder.swift
//  Disney Characters
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

struct DCURLParameterEncoder: DCParameterEncoder {

    public func encode(urlRequest: inout URLRequest, with parameters: DCParameters) throws {
        guard let url = urlRequest.url else { throw DCNetworkError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let parameters = parameters as? [String: AnyHashable] {

            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: key, value: encodedValue)
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: DCNetworkConstants.contentType) == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8",
                                forHTTPHeaderField: DCNetworkConstants.contentType)
        }
    }
}
