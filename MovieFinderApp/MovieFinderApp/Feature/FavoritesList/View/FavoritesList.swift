//
//  FavoritesList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct FavoritesList: View {
    @State private var showItems = true
    @State var serchQuery = ""
    @EnvironmentObject var model: FavoriteViewModel
    var filteredMovies: [Movie] {
        if serchQuery.isEmpty {
            return model.isFavoriteMovies
        } else {
            return model.isFavoriteMovies.filter { $0.name?.localizedCaseInsensitiveContains(serchQuery) ?? false }
        }
    }

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
                    })
                    Spacer()
                }
                .padding(.leading)
                ListView(movies: filteredMovies, showItems: $showItems)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("List of favorites")
            .searchable(text: $serchQuery, placement: .toolbar, prompt: "Search favorites")
        }
    }
}

#Preview {
    FavoritesList()
        .environmentObject(FavoriteViewModel(repository: MovieRepository()))
}
