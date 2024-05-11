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
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: character.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                default:
                    Image(systemName: "photo.circle")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
            }
            .frame(width: 70, height: 70)
            
            Text(character.name)
                .bold()
            Spacer()
            Image(systemName: character.isBookmarked ? "star.fill" : "star")
                .foregroundStyle(.blue)
        }
    }
}
