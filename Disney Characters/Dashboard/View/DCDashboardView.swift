//
//  DCDashboardView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCDashboardView: View, Sendable {
    @State var searchText: String = ""
    @StateObject var viewModel: DCDashboardViewModel
    
    var body: some View {
        NavigationStack {
            containerView
                .onAppear(perform: viewDidLoad)
                .navigationTitle("Dashboard")
                .alert(viewModel.getNetworkError(), isPresented: $viewModel.isError) {
                    Button("Retry") {
                        viewDidLoad()
                    }
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { oldValue, newValue in
                    viewModel.didSearchCharacters(newValue)
                }
        }
    }
}

private extension DCDashboardView {
    
    func viewDidLoad() {
        if viewModel.charactersDisplayModels.isEmpty {
            Task {
                await viewModel.setup()
            }
        }
    }
    
    var containerView: some View {
        VStack {
            if viewModel.isFetchingData {
                DCFetcherView()
            } else {
                if viewModel.isSearchError {
                    ContentUnavailableView.search
                } else {
                    dataListView
                }
            }
        }
    }
    
    var dataListView: some View {
        List {
            let characterDisplayModels = viewModel.charactersDisplayModels
            let bookmarkedCharacters = viewModel.getBookmarkedCharacters()
            
            if !bookmarkedCharacters.isEmpty {
                Section("Bookmarked Characters") {
                    bookmarkedCharactersView(bookmarkedCharacters)
                }
            }
            
            if !characterDisplayModels.isEmpty {
                Section("All Characters") {
                    characterView(characterDisplayModels)
                }
            }
        }
    }
    
    func characterView(_ characters: [DCCharacterDisplayModel]) -> some View {
        ForEach(characters) { character in
            NavigationLink {
                Text(character.name)
            } label: {
                DCCharacterView(
                    character: character
                ) {
                    viewModel.didTapBookmarkCharacter(character)
                }
            }
        }
    }
    
    func bookmarkedCharactersView(_ characters: [DCCharacterDisplayModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(characters) { character in
                    NavigationLink {
                        Text(character.name)
                    } label: {
                        DCCharacterImageView(imagePath: character.imageUrl)
                    }
                }
            }
        }
    }
}

#Preview {
    DCDashboardView(
        viewModel: DCDashboardViewModel()
    )
}
