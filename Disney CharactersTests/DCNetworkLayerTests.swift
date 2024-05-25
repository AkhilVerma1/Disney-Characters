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
            baseURL: URL(string: "https://api.github.com")!,
            path: path,
            httpMethod: .get,
            task: .request
        )
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch([DCGithubTestResponseModel].self)
                
        XCTAssertGreaterThan(result!.responseModel!.count, 0)
    }
    
    func testShouldReturnAInvalidResponseOnInvalidRequestParameters() async throws {
        let task: DCHTTPTask = .requestParameters(
            bodyParameters: ["fake": "fake"],
            bodyEncoding: .urlAndJsonEncoding,
            urlParameters: "empty"
        )
        
        let request = DCRequestType(
            baseURL: URL(string: "fake")!,
            path: "",
            httpMethod: .get,
            task: task
        )
        
        let result = try? await DCAPIFetcher
            .init()
            .withAPI(request)
            .setFetchMode(.online)
            .fetch(DCGithubTestResponseModel.self)
        
        XCTAssertNil(result?.responseModel)
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
            baseURL: URL(string: "https://invalid.github.com")!,
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
        let headers = ["shouldfail": "failing case"]
        
        let task: DCHTTPTask = .requestParametersAndHeaders(
            bodyParameters: headers,
            bodyEncoding: .urlEncoding,
            urlParameters: headers,
            additionHeaders: headers
        )
        
        let request = DCRequestType(
            baseURL: URL(string: "https://invalid.github.com")!,
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
}

struct DCGithubTestResponseModel: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: TypeEnum
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

