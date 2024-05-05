//
//  DCFetcher.swift
//  Disney Characters
//
//  Created by Akhil Verma on 22/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

protocol DCFetcher {
    var api: DCRequestType? { get set }
    var fetchMode: DCAPIMode { get set }

    func withAPI(_ api: DCRequestType) -> Self
    func setFetchMode(_ mode: DCAPIMode) -> Self

    func fetch<T: DCAPIResponse>(_ model: T.Type) async throws -> (responseModel: T?, error: String?)
}
