//
//  DCAPIFetcher.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCAPIFetcher: DCFetcher {
    var api: DCRequestType?
    var fetchMode: DCAPIMode = .online

    func withAPI(_ api: DCRequestType?) -> Self {
        self.api = api
        return self
    }

    func setFetchMode(_ mode: DCAPIMode) -> Self {
        fetchMode = mode
        return self
    }

    func fetch<T>(_ model: T.Type) async throws -> (responseModel: T?, error: String?) where T: Codable {
        do {
            return try await DCNetworkManager.init().request(api)
        } catch {
            return (nil, DCNetworkResponse.failed.rawValue)
        }
    }
}
