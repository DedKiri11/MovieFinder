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
    @State var isSearching = false
    @State private var selectedMovie: Movie?
    
    var body: some View {
        VStack {
            Text(!isSearching ? "Top movies": "Search")
                .font(.largeTitle)
            SearchBar(searchText: $model.searchResponse, isSerching: $isSearching, action:
                        model.search, cancelAction: model.cancelSearch)
            .padding()
            ScrollView(.vertical) {
                LazyVGrid(columns: [
                    .init(.adaptive(minimum: Constants.vGridColumnMinMovieList))
                ], spacing: Constants.vGridSpacingMovieList) {
                    ForEach(isSearching ? model.responseData : model.movies, id: \.self) { movie in
                        MovieListCard(movie: movie)
                            .onTapGesture {
                                selectedMovie = movie
                            }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showItems = true
                        }
                    }
                }
                .defaultScrollAnchor(.top)
                .scrollIndicators(.hidden)
                if model.isLoadMore || !showItems {
                    ProgressView()
                } else {
                    if !isSearching {
                        Button(action: {
                            model.isLoadMore = true
                            model.loadMoreItems()
                        }, label: {
                            Text(model.isEnd ? "This is the end" : "Load more")
                                .padding()
                                .background(RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                                    .fill(Color.white)
                                )
                                .foregroundColor(.black)
                        })
                        .disabled(model.isEnd)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                    }
                }
            }
            .fullScreenCover(item: $selectedMovie) { movie in
                MovieDetail(model: DetailViewModel(movie: movie), movie: movie)
            }
            .scrollIndicators(.hidden)
            .opacity(showItems ? Constants.opacity1 : Constants.opacity02)
            .animation(.easeInOut(duration: Constants.cardAnimationDurationMovieList), value: showItems)
        }
    }
}

#Preview {
    MovieList()
}
