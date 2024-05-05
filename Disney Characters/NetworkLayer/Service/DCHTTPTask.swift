//
//  DCHTTPTask.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

typealias DCHTTPHeaders = [String: String]

enum DCHTTPTask {
    case request

    case requestParameters(bodyParameters: DCParameters?,
        bodyEncoding: DCParameterEncoding,
        urlParameters: DCParameters?)

    case requestParametersAndHeaders(bodyParameters: DCParameters?,
        bodyEncoding: DCParameterEncoding,
        urlParameters: DCParameters?,
        additionHeaders: DCHTTPHeaders?)
}
