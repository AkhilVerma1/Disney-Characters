//
//  DCRouter.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCRouter {

    func request(_ route: DCRequestType) async throws -> (Data, URLResponse) {
        do {
            let request = try self.buildRequest(from: route)
            DCNetworkLogger.log(request: request)
            let result = try await DCRequestExecutor().execute(request)
            debugPrint("request response in router: \(result.1.description)")
            return result
        }
    }
}

private extension DCRouter {

    func buildRequest(from route: DCRequestType) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)

        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue(DCNetworkConstants.applicationJson, forHTTPHeaderField: DCNetworkConstants.contentType)
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):

                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)

            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):

                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        }
    }

    func configureParameters(bodyParameters: DCParameters?,
                             bodyEncoding: DCParameterEncoding,
                             urlParameters: DCParameters?,
                             request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        }
    }

    func addAdditionalHeaders(_ additionalHeaders: DCHTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
