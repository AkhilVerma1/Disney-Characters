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

    func getGithubConfiguration() -> DCRequestType {
        DCRequestType(baseURL: DCURL.shared.getBaseURL(),
                      path: "users",
                      httpMethod: .get,
                      task: .request)
    }
}
