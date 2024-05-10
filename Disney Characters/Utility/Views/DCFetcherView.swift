//
//  DCFetcherView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 10/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCFetcherView: View {
    var body: some View {
        HStack(spacing: 10) {
            ProgressView()
            Text("Fetching")
        }
    }
}

#Preview {
    DCFetcherView()
}
