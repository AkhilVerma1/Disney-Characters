//
//  DCParameterEncoding.swift
//  Disney Characters
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

public typealias DCParameters = Any?

protocol DCParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: DCParameters) throws
}

enum DCParameterEncoding {

    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding

    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: DCParameters?,
                       urlParameters: DCParameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try DCURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)

            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try DCJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)

            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                      let urlParameters = urlParameters else { return }
                try DCURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try DCJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        }
    }
}
