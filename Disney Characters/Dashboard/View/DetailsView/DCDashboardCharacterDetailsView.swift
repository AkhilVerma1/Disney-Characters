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
    
    private let imageSize = CGSize(
        width: UIScreen.main.bounds.width - 10,
        height: 400
    )
    
    var body: some View {
        VStack(alignment: .center) {
            DCCharacterImageView(
                imagePath: character.imageUrl,
                imageSize: imageSize
            )
            
            Spacer()
        }
        .padding()
        .navigationTitle(character.name)
    }
}

#Preview {
    DCDashboardCharacterDetailsView(
        character: DCCharacterDisplayModel(
            id: 1,
            name: "Shubham Handa",
            imageUrl: "AppIcon",
            isBookmarked: false
        )
    )
}
