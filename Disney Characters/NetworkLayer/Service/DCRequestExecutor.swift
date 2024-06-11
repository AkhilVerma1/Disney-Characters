//
//  DCRequestExecutor.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

private actor DCSessionManager {
    private var session: URLSession?

    func setup(apiTimeOut: Double, delegate: URLSessionDelegate) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = apiTimeOut

        session = URLSession(configuration: configuration,
                             delegate: delegate,
                             delegateQueue: nil)
    }

    func getSession(delegate: URLSessionDelegate) -> URLSession {
        session ?? URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    }
}

final class DCRequestExecutor: NSObject, URLSessionDelegate, @unchecked Sendable {
    private let sessionManager = DCSessionManager()
    private let apiTimeOut: Double = 90

    override init() {
        super.init()
        Task {
            await sessionManager.setup(apiTimeOut: apiTimeOut, delegate: self)
        }
    }

    func execute(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let session = await sessionManager.getSession(delegate: self)
            return try await session.data(for: request)
        } catch {
            throw error
        }
    }
}
