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
    @State var isFilter: Bool = false
    
    var body: some View {
        VStack {
            Text(!isSearching ? "Top movies": "Search")
                .font(.largeTitle)
            HStack {
                SearchBar(searchText: $model.searchQuery, isSerching: $isSearching, action:
                            model.search, cancelAction: model.cancelSearch)
                .padding()
                Button(
                    action: { isFilter.toggle() },
                    label: {
                        VStack {
                            Image(systemName: "list.clipboard")
                                .frame(width: Constants.filterButtonWidthMovieList)
                            Text("Filters")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .padding(.trailing)
                    })
                .sheet(isPresented: $isFilter) {
                    FilterView(filterQuery: $model.filterQuery)
                        .presentationDetents([.height(Constants.filterSheetHeight)])
                        .presentationBackground(.thinMaterial)
                        .onDisappear {
                            model.cancelSearch()
                            if model.filterQuery.isEmpty {
                                model.isFilter = false
                            } else {
                                model.isFilter = true
                                model.filter()
                            }
                        }
                }
            }
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVGrid(columns: [
                        .init(.adaptive(minimum: Constants.vGridColumnMinMovieList))
                    ], spacing: Constants.vGridSpacingMovieList) {
                        ForEach(model.movies, id: \.self) { movie in
                            MovieListCard(movie: movie)
                                .onTapGesture {
                                    selectedMovie = movie
                                }
                        }
                        .id(0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showItems = true
                            }
                        }
                    }
                    if model.isLoadMore || !showItems {
                        ProgressView()
                    } else {
                        if !isSearching {
                            Button(action: {
                                model.isLoadMore = true
                                if model.isFilter {
                                    withAnimation {
                                        proxy.scrollTo(0, anchor: .bottom)
                                    }
                                }
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
                .animation(.spring(duration: Constants.cardAnimationDurationMovieList), value: showItems)
            }
        }
    }
}

#Preview {
    MovieList()
}
