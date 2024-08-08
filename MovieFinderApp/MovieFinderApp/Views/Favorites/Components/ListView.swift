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
                    .opacity(showItems ? 1 : 0)
                    .offset(y: showItems ? 0 : 1)
                    .animation(
                        .spring(
                            duration: Constants.cardAnimationDurationMovieList
                        )
                        .delay(
                            Double(
                                movies.firstIndex(of: movie)!) * 0.05
                        ),
                        value: showItems)
                }
            }
        }
        
    }
}
