//
//  MovieListCard.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI
import Foundation

private extension CGFloat {
    static let imageHeight = 145.0
    static let imageWidht = 100.0
    static let cornerRadius = 16.0
    static let tileHeight = 353.0
}

struct MovieListCard: View {
    var movie: Movie
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.posterUrlPreview ?? "")) { image in
                image.image?
                    .resizable()
            }
            .frame(width: .imageWidht, height: .imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
}

#Preview {
    MovieListCard(movie: Movie.default)
}
