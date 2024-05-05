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
        configurations[.github] = getGithubConfiguration()
    }
    
    func getConfiguration(_ request: DCRequests) -> DCRequestType? {
        configurations[request]
    }
}

private extension DCRequestConfiguration {
    
    func getGithubConfiguration() -> DCRequestType? {
        guard let baseURL = DCURL.shared.getBaseURL() else { return nil }
        let path = "users"
        
        return DCRequestType(
            baseURL: baseURL,
            path: path,
            httpMethod: .get,
            task: .request
        )
    }
}
