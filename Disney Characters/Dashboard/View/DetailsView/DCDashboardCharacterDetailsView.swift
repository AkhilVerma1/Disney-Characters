//
//  DCDashboardCharacterDetailsView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 11/06/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCDashboardCharacterDetailsView: View {
    var character: DCCharacterDisplayModel
    
    var body: some View {
        VStack {
            DCCharacterImageView(
                imagePath: character.imageUrl,
                imageSize: CGSize(width: 350, height: 350)
            )
            
            Text(character.name)
                .font(.headline)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DCDashboardCharacterDetailsView(
        character: DCCharacterDisplayModel(
            name: "Shubham Handa",
            imageUrl: "AppIcon",
            isBookmarked: false
        )
    )
}
