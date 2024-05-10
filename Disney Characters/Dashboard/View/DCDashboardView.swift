//
//  DCDashboardView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCDashboardView: View {
    @StateObject var viewModel: DCDashboardViewModel
    
    var body: some View {
        NavigationStack {
            viewModel.getCharactersView()
            .onAppear {
                Task {
                    await viewModel.setup()
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DCDashboardView(
        viewModel: DCDashboardViewModel()
    )
}
