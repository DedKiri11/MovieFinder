//
//  FavoritesListTile.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct FavoritesListTile: View {
    var movie: Movie
    var body: some View {
        VStack {
            HStack {
                VStack {
                    AsyncImageView(imageURL: movie.posterUrlPreview)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                        .frame(width: Constants.imageHeightFavoritesListTile, height: Constants.imageWidhtFavoritesListTile)
                }
                VStack(alignment: .leading) {
                    Text(movie.name ?? Constants.emptyString)
                        .lineLimit(1)
                        .font(.headline)
                    Text(movie.genres?
                        .compactMap {
                            $0.genre
                        }.joined(separator: ", ") ?? Constants.emptyString)
                    .lineLimit(1)
                    Text(String(movie.year))
                }
                .foregroundStyle(Color.white)
                .padding(.leading)
                Spacer()
            }
            .frame(height: Constants.tileHeightFavoritesListTile)
            .background(Color.gray
                .opacity(Constants.opacity02))
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
        }
    }
}

#Preview {
    FavoritesListTile(movie: Movie.default)
}
