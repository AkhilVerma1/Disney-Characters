//
//  DCRequestType.swift
//  Disney Characters
//
//  Created by Akhil Verma on 24/04/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCRequestType {
    var baseURL: URL
    let path: String
    let httpMethod: DCHTTPMethod
    let task: DCHTTPTask
    let headers: DCHTTPHeaders?

    init(baseURL: URL, path: String, httpMethod: DCHTTPMethod, task: DCHTTPTask, headers: DCHTTPHeaders? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.task = task
        self.headers = headers
        self.httpMethod = httpMethod
    }
}
