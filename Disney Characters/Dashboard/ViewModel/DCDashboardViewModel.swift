//
//  DCDashboardViewModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

class DCDashboardViewModel: ObservableObject {
    @Published var isError = false
    @Published var isFetchingData = false
    @Published var charactersDisplayModels: [DCCharacterDisplayModel] = []
    
    private var networkError: String?
    private var characters: DCCharacterModel?
    
    @MainActor
    func setup() async {
        isError = false
        isFetchingData.toggle()
        
        do {
            characters = try await DCCharacterModel.getCharacters()
            charactersDisplayModels = getCharactersDisplayModel(characters?.data ?? [])
        } catch {
            isError.toggle()
            networkError = error.localizedDescription
        }
        
        isFetchingData.toggle()
    }
    
    func didTapBookmarkCharacter(_ character: DCCharacterDisplayModel) {
        guard let index = charactersDisplayModels.firstIndex(of: character) else { return }
        charactersDisplayModels[index] = character
        charactersDisplayModels[index].isBookmarked.toggle()
    }
    
    func getBookmarkedCharacters() -> [DCCharacterDisplayModel] {
        charactersDisplayModels.filter { $0.isBookmarked }
    }
    
    func getNetworkError() -> String {
        networkError ?? DCCustomError.SWR.rawValue
    }
}

private extension DCDashboardViewModel {
    
    func getCharactersDisplayModel(_ characters: [DCCharacterAPIDataModel]) -> [DCCharacterDisplayModel] {
        characters.compactMap {
            guard let name = $0.name, let imageURL = $0.imageUrl else { return nil }
            return DCCharacterDisplayModel(
                name: name,
                imageUrl: imageURL,
                isBookmarked: isCharacterBookmarked($0._id)
            )
        }
    }
    
    func isCharacterBookmarked(_ id: Int?) -> Bool {
            
        // compare the ID with local storage id
    
        false
    }
}
