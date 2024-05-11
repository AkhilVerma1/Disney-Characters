//
//  DCCharacterDisplayModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 10/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

struct DCCharacterDisplayModel: Identifiable, Equatable {
    var name: String
    var imageUrl: String
    var isBookmarked: Bool
    var id: String = UUID().uuidString
}
