//
//  DCCharacterView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 10/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI
import Combine

struct DCCharacterView: View {
    var character: DCCharacterDisplayModel
    var bookmarkSubject: PassthroughSubject<DCCharacterDisplayModel, Never>
    
    var body: some View {
        HStack {
            DCCharacterImageView(imagePath: character.imageUrl)
                .frame(width: 70, height: 70)
            
            Text(character.name)
                .bold()
            
            Spacer()
            
            Image(systemName: character.isBookmarked ? "star.fill" : "star")
                .foregroundStyle(.blue)
                .onTapGesture {
                    bookmarkSubject.send(character)
                }
        }
    }
}

#Preview {
    DCCharacterView(
        character: DCCharacterDisplayModel(
            id: 1,
            name: "Disney Character",
            imageUrl: "",
            isBookmarked: false),
        bookmarkSubject: .init()
    )
}
