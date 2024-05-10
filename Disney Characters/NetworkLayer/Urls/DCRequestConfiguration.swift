//
//  DCRequestConfiguration.swift
//  Disney Characters
//
//  Created by Akhil Verma on 25/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCRequestConfiguration {
    static let shared = DCRequestConfiguration()
    private var configurations: [DCRequests: DCRequestType] = [:]
    
    private init() {
        configurations[.disneyCharacters] = getDisneyCharacterConfiguration()
    }
    
    func getConfiguration(_ request: DCRequests) -> DCRequestType? {
        configurations[request]
    }
}

private extension DCRequestConfiguration {
    
    func getDisneyCharacterConfiguration() -> DCRequestType? {
        guard let baseURL = DCURL.shared.getBaseURL() else { return nil }
        return DCRequestType(
            baseURL: baseURL,
            path: DCURLPath.character,
            httpMethod: .get,
            task: .request
        )
    }
}
