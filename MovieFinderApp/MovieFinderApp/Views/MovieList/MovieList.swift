//
//  MovieList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI



struct MovieList: View {
    @StateObject var model = MovieViewModel()
    @State private var showItems = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: [
                    .init(.adaptive(minimum: Constants.vGridColumnMinMovieList))
                ], spacing: Constants.vGridSpacingMovieList) {
                    ForEach(model.movies, id: \.self) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie)) {
                            MovieListCard(movie: movie)
                        }
                        .opacity(showItems ? Constants.opacity1 : Constants.opacity02)
                        .animation(.easeInOut(duration: Constants.cardAnimationDurationMovieList), value: showItems)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showItems = true
                        }
                    }
                }
                .navigationTitle("Top movies")
                .defaultScrollAnchor(.top)
                .scrollIndicators(.hidden)
            }
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
        }
    }
}
    
    #Preview {
        MovieList()
    }
