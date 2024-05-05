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
            List {
                HStack(spacing: 20) {
                    Spacer()
                    circleView
                    circleView
                    Spacer()
                }
                .listRowSeparator(.hidden)

                VStack(spacing: 20) {
                    Spacer()
                    circleView
                    circleView
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Dashboard")
        }
    }
    
    private var circleView: some View {
        ZStack {
            Circle()
                .frame(height: 100)
                .foregroundStyle(LinearGradient(
                    colors: [.pink, .red.opacity(0.5), .brown],
                    startPoint: .top,
                    endPoint: .bottom)
                )
                .shadow(radius: 3, x: 7, y: 1)
            
            Circle()
                .foregroundStyle(.white)
                .frame(height: 70)
                .shadow(radius: 2)
            
            Circle()
                .frame(height: 25)
        }
    }
}

#Preview {
    DCDashboardView(
        viewModel: DCDashboardViewModel()
    )
}
