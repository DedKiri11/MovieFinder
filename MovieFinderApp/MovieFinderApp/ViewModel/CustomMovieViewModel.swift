//
//  CustomMovieViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import Foundation

class CustomMovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
}
