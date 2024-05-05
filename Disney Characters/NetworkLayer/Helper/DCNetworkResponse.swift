//
//  DCNetworkResponse.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

enum DCNetworkResponse: String {
    case success
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case authenticationError = "You need to be authenticated first."
    case failed = "Unable to process your request, Please try again after sometime"
}
