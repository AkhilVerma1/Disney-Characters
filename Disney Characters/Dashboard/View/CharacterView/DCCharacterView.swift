//
//  DCCharacterView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 10/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCCharacterView: View {
    var character: DCCharacterDisplayModel
    var onTap: () -> Void
    
    var body: some View {
        HStack {
            DCCharacterImageView(imagePath: character.imageUrl)
            Text(character.name)
                .bold()
            
            Spacer()
            
            Image(systemName: character.isBookmarked ? "star.fill" : "star")
                .foregroundStyle(.blue)
                .onTapGesture {
                    onTap()
                }
        }
    }
}

#Preview {
    DCCharacterView(character: DCCharacterDisplayModel(name: "", imageUrl: "", isBookmarked: false)) {
        
    }
}
