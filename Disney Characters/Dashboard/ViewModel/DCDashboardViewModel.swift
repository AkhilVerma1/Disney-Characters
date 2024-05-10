//
//  DCDashboardViewModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

class DCDashboardViewModel: ObservableObject {
    @Published var isFetchingData = false
    @Published var characters: DCCharacterModel?
    
    @MainActor
    func setup() async {
        isFetchingData.toggle()
        characters = await DCCharacterModel.getCharacters()
        isFetchingData.toggle()
    }
    
    func getCharactersView() -> some View {
        VStack {
            if isFetchingData {
                DCFetcherView()
            } else {
                if let characters = characters?.data {
                    let characterDisplayModel = getCharactersDisplayModel(characters)
                    DCCharacterView(characters: characterDisplayModel)
                } else {
                    ContentUnavailableView.search
                }
            }
        }
    }
    
    func getCharactersDisplayModel(_ characters: [DCCharacterAPIDataModel]) -> [DCCharacterDisplayModel] {
        characters.compactMap {
            guard let name = $0.name, let imageURL = $0.imageUrl else { return nil }
            return DCCharacterDisplayModel(
                name: name,
                imageUrl: imageURL,
                isBookmarked: false
            )
        }
    }
}
