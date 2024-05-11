//
//  DCCharacterImageView.swift
//  Disney Characters
//
//  Created by Akhil Verma on 11/05/24.
//  Copyright © 2024 OCloud Labs. All rights reserved.
//

import SwiftUI

struct DCCharacterImageView: View {
    var imagePath: String
    
    var body: some View {
        CachedAsyncImage(url: URL(string: imagePath)) { phase in
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
    }
}

#Preview {
    DCCharacterImageView(imagePath: "")
}
