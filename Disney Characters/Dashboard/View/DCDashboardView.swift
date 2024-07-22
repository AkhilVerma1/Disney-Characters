//
//  DCDashboardView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import Combine

struct DCDashboardView: View, Sendable {
    @State var searchText: String = ""
    @StateObject var viewModel: DCDashboardViewModel
    
    var body: some View {
        NavigationStack {
            containerView
                .onAppear(perform: viewDidLoad)
                .navigationTitle("Dashboard")
                .alert(viewModel.getNetworkError(), isPresented: $viewModel.isError) {
                    alertView
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
        viewModel.viewDidAppear()
    }
    
    var alertView: some View {
        Button("Retry") {
            viewModel.viewDidAppear()
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
            let bookmarkedCharacters = viewModel.getBookmarkedCharacters()
            let characterDisplayModels = viewModel.charactersDisplayModels
            
            Section("Bookmarked Characters") {
                bookmarkedCharactersView(bookmarkedCharacters)
                    .listRowSeparator(.hidden)
            }
            
            Section("All Characters") {
                characterView(characterDisplayModels)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    func characterView(_ characters: [DCCharacterDisplayModel]) -> some View {
        ForEach(characters) { character in
            NavigationLink {
                DCDashboardCharacterDetailsView(character: character)
            } label: {
                DCCharacterView(
                    character: character,
                    bookmarkSubject: viewModel.bookmarkSubject
                )
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
