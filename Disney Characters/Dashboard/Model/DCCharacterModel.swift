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
    
    static func getCharacters(_ api: DCRequestType?) async throws -> DCCharacterModel? {
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
    case noRecordFound = "No Record Found"
    case invalidRequest = "Invalid Request"
    
    var localizedDescription: String {
          switch self {
          case .SWR:
              return NSLocalizedString("Something went wrong", comment: "")
          case .noRecordFound:
              return NSLocalizedString("No Record Found", comment: "")
          case .invalidRequest:
              return NSLocalizedString("Invalid Request", comment: "")
          }
      }
}
