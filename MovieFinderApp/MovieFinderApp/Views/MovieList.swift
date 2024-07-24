//
//  MovieList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI

private extension CGFloat {
    static let cornerRadius = 15.0
    static let vGridSpacing = 10.0
    static let vColumnMin = 100.0
}

struct MovieList: View {
    @Environment(MovieViewModel.self) var model
    let movieListTitle = "Top movies"
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: [
                    .init(.adaptive(minimum: .vColumnMin))
                ], spacing: .vGridSpacing) {
                    ForEach(model.movies, id: \.self) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie)) {
                            MovieListCard(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle(movieListTitle)
            .defaultScrollAnchor(.top)
            .scrollIndicators(.hidden)
        }
        .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
}

#Preview {
    MovieList()
}
