//
//  DCCharacterAPIDataModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 10/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

struct DCCharacterAPIDataModel: Codable, Identifiable {
    let _id: Int?
    let url: String?
    let name: String?
    let imageUrl: String?
    var id: String = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case _id
        case url
        case name
        case imageUrl
    }
}
