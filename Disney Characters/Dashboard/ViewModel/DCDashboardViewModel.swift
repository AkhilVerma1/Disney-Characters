//
//  DCDashboardViewModel.swift
//  Disney Characters
//
//  Created by Akhil Verma on 04/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import Combine
import SwiftData

class DCDashboardViewModel: ObservableObject {
    @Published var isError = false
    @Published var isSearchError = false
    @Published var isFetchingData = false
    @Published var charactersDisplayModels: [DCCharacterDisplayModel] = []

    private var bookmarkedCharacteresDisplayModel: [DCCharacterDisplayModel] = []
    
    private var modelContext: ModelContext?
    
    let bookmarkSubject = PassthroughSubject<DCCharacterDisplayModel, Never>()
    
    private var networkError: String?
    private var characters: DCCharacterModel?
    private var cancellables = Set<AnyCancellable>()
    
    init(_ modelContext: ModelContext?) {
        self.modelContext = modelContext
        
        bookmarkSubject
            .sink { [weak self] character in
                self?.didTapBookmarkCharacter(character)
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func viewDidAppear() {
        updateBookmarkedCharacters()
        
        if charactersDisplayModels.isEmpty {
            Task {
                await setup()
            }
        }
    }
    
    func updateBookmarkedCharacters() {
        bookmarkedCharacteresDisplayModel = getLocalStorageCharacters().compactMap {
            DCCharacterDisplayModel(
                id: $0.id,
                name: $0.name,
                imageUrl: $0.imageUrl,
                isBookmarked: true
            )
        }
    }
    
    private func getLocalStorageCharacters() -> [DCCharactersLocalStorageDataModel] {
        let descriptor = FetchDescriptor<DCCharactersLocalStorageDataModel>(sortBy: [SortDescriptor(\.time)])
        return (try? modelContext?.fetch(descriptor)) ?? []
    }
    
    @MainActor
    private func setup(_ api: DCRequestType? = DCRequestConfiguration.shared.getConfiguration(.disneyCharacters)) async {
        isError = false
        isFetchingData.toggle()
        
        let disneyAPI = DCRequestType(
            baseURL: DCURL.shared.getBaseURL() ?? URL(filePath: ""),
            path: DCURLPath.character,
            httpMethod: .get,
            task: .request
        )
        
        do {
            guard let characters = try await DCCharacterModel.getCharacters(disneyAPI) else { throw DCCustomError.noRecordFound }
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
        charactersDisplayModels = searchText.isEmpty ? characters : characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearchError = searchText.isEmpty ? false : charactersDisplayModels.isEmpty
    }
    
    func didTapBookmarkCharacter(_ character: DCCharacterDisplayModel) {
        let item = DCCharactersLocalStorageDataModel(id: character.id, time: .now, name: character.name, imageUrl: character.imageUrl)
        character.isBookmarked ? modelContext?.delete(item) : modelContext?.insert(item)
        updateBookmarkedCharacters()
        guard let index = charactersDisplayModels.firstIndex(of: character) else { return }
        charactersDisplayModels[index].isBookmarked.toggle()
    }
    
    func getBookmarkedCharacters() -> [DCCharacterDisplayModel] {
        bookmarkedCharacteresDisplayModel
    }
    
    func getNetworkError() -> String {
        networkError ?? DCCustomError.SWR.rawValue
    }
}

private extension DCDashboardViewModel {
    
    func getCharactersDisplayModel(_ characters: [DCCharacterAPIDataModel]) -> [DCCharacterDisplayModel] {
        characters.compactMap {
            guard let name = $0.name, let imageURL = $0.imageUrl, let id = $0._id else { return nil }
            return DCCharacterDisplayModel(
                id: id,
                name: name,
                imageUrl: imageURL,
                isBookmarked: isCharacterBookmarked(id)
            )
        }
    }
    
    func isCharacterBookmarked(_ id: Int) -> Bool {
        bookmarkedCharacteresDisplayModel.contains { $0.id == id }
    }
}
