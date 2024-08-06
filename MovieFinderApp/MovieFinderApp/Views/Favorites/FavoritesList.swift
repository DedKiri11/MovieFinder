//
//  FavoritesList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct FavoritesList: View {
    @State var serchQuery = ""
    @StateObject var model = FavoriteViewModel()
    var filteredMovies: [Movie]  {
        if serchQuery.isEmpty {
            return model.isFavoriteMovies
        } else {
            return model.isFavoriteMovies.filter { $0.name?.localizedCaseInsensitiveContains(serchQuery) ?? false }
        }
    }
    @State private var showItems = true
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    DateFilterView(isLatest: $model.isLatest, action: {
                        showItems.toggle()
                        model.filterByDate()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showItems = true
                            }
                    }
                    )
                    Spacer()
                }
                .padding(.leading)
                LazyVStack {
                    ForEach(filteredMovies.indices, id: \.self) { index in
                        let movie = filteredMovies[index]
                        if movie.isFavorite {
                            NavigationLink(
                                destination: MovieDetail(model: DetailViewModel(movie: movie), movie: movie)
                            ) {
                                FavoritesListTile(movie: movie)
                            }
                            .opacity(showItems ? 1 : 0)
                            .offset(y: showItems ? 0 : 1)
                            .animation(.easeInOut(duration: Constants.cardAnimationDurationMovieList).delay(Double(index) * 0.05), value: showItems)
                        }
                    }
                }
            }
            .navigationTitle("List of favorites")
            .searchable(text: $serchQuery, placement: .toolbar, prompt: "Search favorites")
        }
        .scrollIndicators(.hidden)
    }
}




#Preview {
    FavoritesList()
}
