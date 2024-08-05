//
//  FavoritesList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct FavoritesList: View {
    @StateObject var model = FavoriteViewModel()
    @State private var showItems = false
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.isFavoriteMovies, id: \.self) { movie in
                    NavigationLink(
                        destination: MovieDetail(model: DetailViewModel(movie: movie), movie: movie)
                    ) {
                        MovieListCard(movie: movie)
                    }
                    .opacity(showItems ? Constants.opacity1 : Constants.opacity02)
                    .animation(.easeInOut(duration: Constants.cardAnimationDurationMovieList), value: showItems)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showItems = true
                    }
            }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FavoritesList()
}
