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
        HStack {
            AsyncImage(url: URL(string: movie.posterUrlPreview)) { image in
                image.image?
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                    .frame(width: Constants.imageHeightFavoritesListTile, height: Constants.imageWidhtFavoritesListTile)
            }
            VStack(alignment: .leading) {
                Text(movie.name ?? "")
                    .lineLimit(1)
                    .font(.headline)
                
                Text(movie.genres?
                    .compactMap {
                        $0.genre
                    }.joined(separator: ", ") ?? "")
                .lineLimit(1)
                
                Text(String(movie.year))
            }
            .foregroundStyle(Color.white)
            .padding(.leading)
            
            Spacer()
        }
        .background(Color.gray
            .opacity(Constants.opacity02))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
        .frame(width: Constants.tileHeightFavoritesListTile)
    }
}


#Preview {
    FavoritesListTile(movie: Movie.default)
}
