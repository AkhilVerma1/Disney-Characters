//
//  Disney_CharactersApp.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

@main
struct Disney_CharactersApp: App {
    var body: some Scene {
        WindowGroup {
            DCDashboardView(viewModel: DCDashboardViewModel())
        }
    }
}
