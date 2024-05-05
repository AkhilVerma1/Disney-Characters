//
//  DCNetworkError.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

enum DCNetworkError: String, Error {
    case missingURL = "URL is nil."
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
}
