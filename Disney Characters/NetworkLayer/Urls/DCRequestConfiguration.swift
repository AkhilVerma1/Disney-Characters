//
//  DCRequestConfiguration.swift
//  Disney Characters
//
//  Created by Akhil Verma on 25/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation


final class DCRequestConfiguration {
    @MainActor static let shared = DCRequestConfiguration()
    private var configurations: [DCRequests: DCRequestType] = [:]
    
    private init() {
        
    }
    
//    func setupObjects() async {
//        configurations[.disneyCharacters] = await getDisneyCharacterConfiguration()
//    }
    
    func getConfiguration(_ request: DCRequests) -> DCRequestType? {
        configurations[request]
    }
    
    @MainActor
    private func getDisneyCharacterConfiguration() -> DCRequestType? {
        guard let baseURL = DCURL.shared.getBaseURL() else { return nil }
        return DCRequestType(
            baseURL: baseURL,
            path: DCURLPath.character,
            httpMethod: .get,
            task: .request
        )
    }
}
