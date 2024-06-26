//
//  DCNetworkManager.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCNetworkManager {
    
    func request<T: Codable>(_ endPoint: DCRequestType?) async throws -> (responseModel: T?, error: String?) {
        guard let endPoint = endPoint else { throw DCCustomError.invalidRequest }
        do {
            let (data, response) = try await DCRouter.init().request(endPoint)
            return try handleAPIResponse(T.self, data: data, response: response)
        } catch {
            throw error
        }
    }
}

private extension DCNetworkManager {
    
    func getAPIModel<T: Codable>(_ model: T.Type, responseData: Data) -> T? {
        try? JSONDecoder().decode(T.self, from: responseData)
    }
    
    func getAPIError(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any],
              let errorMessage = jsonData[DCNetworkConstants.reason] else { return nil }
        
        return errorMessage as? String
    }
    
    func handleAPIResponse<T: Codable>(_ model: T.Type, data: Data?, response: URLResponse?) throws -> (T?, String?) {
        guard let response = response as? HTTPURLResponse else { throw DCCustomError.invalidRequest }
        
        switch handleNetworkResponse(response) {
        case .success:
            guard let responseData = data else { throw DCCustomError.invalidRequest }
            return (getAPIModel(T.self, responseData: responseData), nil)
            
        case.failure(let networkFailureError):
            return (nil, networkFailureError)
        }
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> DCResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(DCNetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(DCNetworkResponse.badRequest.rawValue)
        case 600: return .failure(DCNetworkResponse.outdated.rawValue)
        default: return .failure(DCNetworkResponse.failed.rawValue)
        }
    }
}
