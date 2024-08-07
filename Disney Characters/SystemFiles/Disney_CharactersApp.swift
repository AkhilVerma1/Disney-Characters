//
//  Disney_CharactersApp.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct Disney_CharactersApp: App {
    
    private var sharedModelContainer: ModelContainer? = {
        let schema = Schema([DCCharactersLocalStorageDataModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        return try? ModelContainer(for: schema, configurations: [modelConfiguration])
    }()
    
    var body: some Scene {
        WindowGroup {
            DCDashboardView(viewModel: DCDashboardViewModel(sharedModelContainer?.mainContext))
        }
    }
}
