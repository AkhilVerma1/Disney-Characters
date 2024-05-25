//
//  DCDashboardViewModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import Combine

class DCDashboardViewModel: ObservableObject {
    @Published var isError = false
    @Published var isSearchError = false
    @Published var isFetchingData = false
    @Published var charactersDisplayModels: [DCCharacterDisplayModel] = []
    private var cancellables = Set<AnyCancellable>()
    let bookmarkSubject = PassthroughSubject<DCCharacterDisplayModel, Never>()
    
    private var networkError: String?
    private var characters: DCCharacterModel?
    
    init() {
        bookmarkSubject
            .sink { [weak self] character in
                self?.didTapBookmarkCharacter(character)
            }
            .store(in: &cancellables)
    }
    
    func getAlertView() -> some View {
        Button("Retry") {
            Task {
                await self.setup()
            }
        }
    }
    
    @MainActor
    func setup(_ api: DCRequestType? = DCRequestConfiguration.shared.getConfiguration(.disneyCharacters)) async {
        isError = false
        isFetchingData.toggle()
        
        do {
            guard let characters = try await DCCharacterModel.getCharacters(api) else { throw DCCustomError.noRecordFound }
            self.characters = characters
            charactersDisplayModels = getCharactersDisplayModel(characters.data)
        } catch {
            isError.toggle()
            networkError = (error as? DCCustomError)?.rawValue ?? error.localizedDescription
        }
        
        isFetchingData.toggle()
    }
    
    @MainActor
    func didSearchCharacters(_ searchText: String) {
        let characters = getCharactersDisplayModel(characters?.data ?? [])
        charactersDisplayModels = searchText.isEmpty ? characters :characters.filter { $0.name.contains(searchText) }
        isSearchError = searchText.isEmpty ? false : charactersDisplayModels.isEmpty
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
    
    func isCharacterBookmarked(_ id: Int?) -> Bool { false }
}
