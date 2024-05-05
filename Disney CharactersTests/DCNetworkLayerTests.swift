//
//  DCNetworkLayerTests.swift
//  Disney CharactersTests
//
//  Created by Akhil Verma on 05/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import XCTest
@testable import Disney_Characters

final class DCNetworkLayerTests: XCTestCase {
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testShouldReturnAValidResponseOnValidRequest() async throws {
        let path = "users"
        
        let request = DCRequestType(
            baseURL: URL(string: "https://api.github.com") ?? URL(filePath: ""),
            path: path,
            httpMethod: .get,
            task: .request
        )
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch(DCGithubTestResponseModel.self)
        
        XCTAssertGreaterThan(result?.responseModel?.githubUsers.count ?? 0, 0)
    }
    
    func testShouldReturnAInvalidResponseOnInvalidRequestParameters() async throws {
        let task: DCHTTPTask = .requestParameters(
            bodyParameters: ["fake": "fake"],
            bodyEncoding: .urlAndJsonEncoding,
            urlParameters: "empty"
        )
        
        let request = DCRequestType(
            baseURL: URL(string: "fake") ?? URL(filePath: ""),
            path: "",
            httpMethod: .get,
            task: task
        )
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch(DCGithubTestResponseModel.self)
        
        XCTAssertNotNil(result?.error)
    }
    
    func testShouldThrowErrorOnInvalidURLAndRequestParametersHeaders() async throws {
        let headers = ["shouldfail": "failing case"]
        
        let task: DCHTTPTask = .requestParametersAndHeaders(
            bodyParameters: headers,
            bodyEncoding: .urlEncoding,
            urlParameters: headers,
            additionHeaders: headers
        )
        
        let request = DCRequestType(
            baseURL: URL(string: "https://invalid.github.com") ?? URL(filePath: ""),
            path: "",
            httpMethod: .get,
            task: task
        )
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch(DCGithubTestResponseModel.self)
        
        XCTAssertNotNil(result?.error)
    }
    
    func testShouldThrowAnErrorOnInvalidURL() async throws {
        let requestType = DCRequestConfiguration.shared.getConfiguration(.github)
        
        guard let request = requestType else {
            XCTAssertNotNil(requestType)
            return
        }
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch(DCGithubTestResponseModel.self)
        
        XCTAssertNotNil(result?.error)
    }
}

class DCGithubTestResponseModel: DCAPIResponse {
    var githubUsers: [DCGithubUserAPIModel] = []

    required init(_ response: Any?) {
        guard let response = response as? [[String: Any]] else { return }
        for user in response {
            githubUsers.append(DCGithubUserAPIModel(user))
        }
    }
}

class DCGithubUserAPIModel {
    var id: Int?
    init(_ response: [String: Any]) {
        id = response[DCGithubUserKeys.id.rawValue] as? Int
    }
}

enum DCGithubUserKeys: String {
    case id = "id"
}
