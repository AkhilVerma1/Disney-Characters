//
//  DCCharacterModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

struct DCCharacterModel: Codable {
    var data: [DCCharacterAPIDataModel] = []
    
    @MainActor
    static func getCharacters() async throws -> DCCharacterModel? {
        let api = DCRequestConfiguration.shared.getConfiguration(.disneyCharacters)
        
        do {
            let result = try await DCAPIFetcher
                .init()
                .withAPI(api)
                .fetch(DCCharacterModel.self)
            return result.responseModel
        } catch {
            throw error
        }
    }
}


enum DCCustomError: String, Error {
    case SWR = "Something went wrong"
}
