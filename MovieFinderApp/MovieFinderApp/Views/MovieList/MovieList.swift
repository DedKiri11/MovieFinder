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
    
    var body: some View {
        NavigationStack {
            SearchBar(searchText: $model.searchResponse, isSerching: $isSearching, action:
                        model.search, cancelAction: model.cancelSearch)
            .padding()
            ScrollView(.vertical) {
                LazyVGrid(columns: [
                    .init(.adaptive(minimum: Constants.vGridColumnMinMovieList))
                ], spacing: Constants.vGridSpacingMovieList) {
                    ForEach(isSearching ? model.responseData : model.movies, id: \.self) { movie in
                        NavigationLink(
                            destination: MovieDetail(movie: movie)
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
                .navigationTitle(!isSearching ? "Top movies": "Search")
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
        }
    }
}

#Preview {
    MovieList()
}
