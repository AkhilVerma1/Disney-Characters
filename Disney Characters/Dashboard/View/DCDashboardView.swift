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
        }
    }
}

private extension DCDashboardView {
    
    func viewDidLoad() {
        Task {
            await viewModel.setup()
        }
    }
    
    var containerView: some View {
        VStack {
            if viewModel.isFetchingData {
                fetcherView
            } else {
                contentView
            }
        }
    }
    
    var fetcherView: some View {
        DCFetcherView()
    }
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.isError {
            Text(viewModel.getNetworkError() ?? "Something went wrong")
        } else {
            dataView
        }
    }
    
    var dataView: some View {
        VStack {
            if !viewModel.charactersDisplayModels.isEmpty {
                List {
                    characterView(viewModel.charactersDisplayModels)
                }
            } else {
                contentUnavaliable
            }
        }
    }
    
    func characterView(_ characters: [DCCharacterDisplayModel]) -> some View {
        ForEach(characters) { character in
            DCCharacterView(
                character: character
            )
            .onTapGesture {
                viewModel.didTapCharacter(character)
            }
        }
    }
    
    var contentUnavaliable: some View {
        ContentUnavailableView.search
    }
}

#Preview {
    DCDashboardView(
        viewModel: DCDashboardViewModel()
    )
}
