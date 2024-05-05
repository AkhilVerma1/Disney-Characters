//
//  DCURL.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCURL {
    static let shared = DCURL()
    private let security = "https://"
    private var infoDict: [String: Any]? = Bundle.main.infoDictionary

    private init() {
        // private init
    }

    func getBaseURL() -> URL? {
        let url = "\(security)\(getServerURL() ?? String())"
        return URL(string: url)
    }
}

private extension DCURL {
    func getServerURL() -> String? {
        let baseURL = infoDict?[DCPlistKey.serverURL.rawValue] as? String
        return baseURL?.replacingOccurrences(of: "\"", with: "")
    }
}

enum DCPlistKey: String {
    case serverURL = "BASE_URL"
}
