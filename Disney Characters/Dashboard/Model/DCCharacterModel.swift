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
    static func getCharacters() async -> DCCharacterModel? {
        let api = DCRequestConfiguration.shared.getConfiguration(.disneyCharacters)
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(api)
            .fetch(DCCharacterModel.self)

        return result?.responseModel
    }
}
