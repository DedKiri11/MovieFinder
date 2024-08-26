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
            AsyncImageView(imageURL: movie.posterUrl)
            .frame(width: Constants.imageWidthMovieListCard, height: Constants.imageHeightMovieListCard)
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
