//
//  MovieList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI

struct MovieList: View {
    @Environment(MovieViewModel.self) var model
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
      ]
    var body: some View {
        Text("Top films")
            .font(.title)
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(model.movies, id: \.self) { movie in
                    MovieListCard(movie: movie)
                }
            }
        }
        .defaultScrollAnchor(.top)
    }
}

#Preview {
    MovieList()
}
