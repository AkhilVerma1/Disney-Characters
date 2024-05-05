//
//  DCJSONParameterEncoder.swift
//  Disney Characters
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

public struct DCJSONParameterEncoder: DCParameterEncoder {

    public func encode(urlRequest: inout URLRequest, with parameters: DCParameters) throws {
        guard let parameters = parameters as? [String: Any] else {
            urlRequest.httpBody = (parameters as? String)?.data(using: .utf8)
            return
        }
        do {
            let jsonAsData = try JSONSerialization.data(
                withJSONObject: parameters,
                options: .withoutEscapingSlashes
            )
            
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: DCNetworkConstants.contentType) == nil {
                urlRequest.setValue(DCNetworkConstants.applicationJson,
                                    forHTTPHeaderField: DCNetworkConstants.contentType)
            }
        } catch { throw DCNetworkError.encodingFailed }
    }
}
