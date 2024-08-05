//
//  MovieListCard.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI
import Foundation

struct MovieListCard: View {
    var movie: Movie
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.posterUrl)) { image in
                image.image?
                    .resizable()
            }
            .frame(width: Constants.imageWidhtMovieListCard, height: Constants.imageHeightMovieListCard)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
            .scaledToFill()
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
    }
}

#Preview {
    MovieListCard(movie: Movie.default)
}
