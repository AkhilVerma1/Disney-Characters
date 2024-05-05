//
//  Disney_CharactersApp.swift
//  Disney Characters
//
//  Created by Akhil Verma on 03/05/24.
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
