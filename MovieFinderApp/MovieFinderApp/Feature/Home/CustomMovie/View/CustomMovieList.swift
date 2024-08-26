//
//  CustomMovieList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import SwiftUI

struct CustomMovieList: View {
    @EnvironmentObject var model: CustomMovieViewModel
    @State var isPresentEditor: Bool = false
    @State private var selectedMovie: Movie?
    var body: some View {
        EditCardView()
            .onTapGesture {
                isPresentEditor.toggle()
            }
            .sheet(isPresented: $isPresentEditor) {
                EditView()
                    .environmentObject(Injection.shared.container.resolve(EditViewModel.self)!)
            }
        ForEach(model.movies.indices, id: \.self) { index in
            MovieListCard(movie: model.movies[index])
                .onTapGesture {
                    selectedMovie = model.movies[index]
                }
        }
        .fullScreenCover(item: $selectedMovie) { movie in
            MovieDetail(
                model: DetailViewModel(
                    movie: movie,
                    repository:  Injection.shared.container.resolve(Repository.self)!
                ),
                isCustomMovie: true
            )
        }
    }
}

#Preview {
    CustomMovieList()
}
