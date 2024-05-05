//
//  DCDashboardViewModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import Foundation

class DCDashboardViewModel: ObservableObject {
    
    @MainActor
    func fetchCharacters() -> DCCharacterModel {
        debugPrint("fetching characters")
        return DCCharacterModel(name: "Disney Demo Character")
    }
}
