//
//  MovieList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI

struct MovieList: View {
    @EnvironmentObject var model: MovieViewModel
    @State private var showItems = true
    @State var isSearching = false
    @State private var selectedMovie: Movie?
    @State var isFilterViewPresented: Bool = false

    var body: some View {
        VStack {
            Text(isSearching || model.isFilter ? "Search" : "Top movies")
                .font(.largeTitle)
            HStack {
                SearchBar(searchText: $model.searchQuery, isSerching: $isSearching, action:
                            model.search, cancelAction: model.cancelSearch)
                .padding()
                Button(
                    action: {
                        if model.isFilter {
                            cardAnimation()
                            model.load()
                            model.isFilter.toggle()
                        } else {
                            isFilterViewPresented.toggle()
                        }
                    },
                    label: {
                        VStack {
                            Image(systemName: model.isFilter ? "return.left" : "list.clipboard")
                                .frame(width: Constants.filterButtonWidthMovieList)
                            Text(model.isFilter ? "Cancel" : "Filters")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .padding(.trailing)
                    })
                .sheet(isPresented: $isFilterViewPresented) {
                    FilterView(filterQuery: $model.filterQuery)
                        .presentationDetents([.height(Constants.filterSheetHeight)])
                        .presentationBackground(.thinMaterial)
                        .onDisappear {
                            if model.filterQuery.isEmpty {
                                model.isFilter = false
                                model.cancelSearch()
                            } else {
                                model.isFilter = true
                                cardAnimation()
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
                        CustomMovieList()
                            .environmentObject(Injection.shared.container.resolve(CustomMovieViewModel.self)!)
                        ForEach(model.movies, id: \.self) { movie in
                            MovieListCard(movie: movie)
                                .onTapGesture {
                                    selectedMovie = movie
                                }
                        }
                        .onAppear {
                            cardAnimation()
                        }
                        .id(0)
                    }
                    if model.isLoadMore || !showItems {
                        ProgressView()
                    } else {
                        if !isSearching {
                            Button(action: {
                                model.isLoadMore = true
                                if model.isFilter {
                                    withAnimation(.spring(duration: 1)) {
                                        proxy.scrollTo(0, anchor: .bottom)
                                    }
                                }
                                cardAnimation()
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
                    MovieDetail(
                        model: DetailViewModel(
                            movie: movie,
                            repository:  Injection.shared.container.resolve(Repository.self)!
                        )
                    )
                }
                .scrollIndicators(.hidden)
                .opacity(showItems ? Constants.opacity1 : Constants.opacity02)
                .animation(.spring(duration: Constants.cardAnimationDurationMovieList), value: showItems)
                .refreshable {
                    model.refresh()
                }
            }
        }
    }
    func cardAnimation() {
        showItems.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showItems.toggle()
        }
    }
}

#Preview {
    MovieList()
}
