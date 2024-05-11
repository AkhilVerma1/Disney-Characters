//
//  DCDashboardView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCDashboardView: View, Sendable {
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
                dataView
            }
        }
    }
    
    var dataView: some View {
        VStack {
            if !viewModel.charactersDisplayModels.isEmpty {
                List {
                    let bookmarkedCharacters = viewModel.getBookmarkedCharacters()
                    if !bookmarkedCharacters.isEmpty {
                        bookmarkedCharactersView(bookmarkedCharacters)
                    }
                    characterView(viewModel.charactersDisplayModels)
                }
            } else {
                contentUnavaliable
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
    
    var contentUnavaliable: some View {
        ContentUnavailableView.init(
            DCCustomError.noRecordFound.rawValue,
            systemImage: "doc.plaintext.fill",
            description: Text(viewModel.getNetworkError())
        )
    }
    
    func bookmarkedCharactersView(_ characters: [DCCharacterDisplayModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(characters) { character in
                    DCCharacterImageView(imagePath: character.imageUrl)
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
