//
//  AsyncImage.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 08.08.2024.
//

import SwiftUI

struct AsyncImageView: View {
    var imageURL: String?
    var body: some View {
        if let imageURL = imageURL {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.image?
                    .resizable()
                    .scaledToFill()
            }
        } else {
            Image(.unknown)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
        }
    }
}
