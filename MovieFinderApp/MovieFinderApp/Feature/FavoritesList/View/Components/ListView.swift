//
//  ListView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 08.08.2024.
//

import SwiftUI

struct ListView: View {
    var movies: [Movie] = []
    @Binding var showItems: Bool
    var body: some View {
        LazyVStack {
            ForEach(movies, id: \.self) { movie in
                if movie.isFavorite {
                    NavigationLink(
                        destination: MovieDetail(model: DetailViewModel(movie: movie, repository: Injection.shared.container.resolve(Repository.self)!))
                    ) {
                        FavoritesListTile(movie: movie)
                    }
                    .animation(
                        .spring(
                            duration: Constants.cardAnimationDurationMovieList
                        )
                        .delay(
                            Double(
                                movies.firstIndex(of: movie)!) * 0.1
                        ),
                        value: showItems)
                }
            }
        }

    }
}
