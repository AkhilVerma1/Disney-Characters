//
//  DCCharactersLocalStorageDataModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 22/07/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class DCCharactersLocalStorageDataModel {
    var id: Int
    var time: Date
    var name: String
    var imageUrl: String

    init(id: Int, time: Date, name: String, imageUrl: String) {
        self.id = id
        self.time = time
        self.name = name
        self.imageUrl = imageUrl
    }
}
