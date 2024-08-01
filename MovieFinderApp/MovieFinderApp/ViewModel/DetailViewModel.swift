//
//  DetailViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var movie = MovieEntity()
    private var repository: MovieRepository?
    @Published var isAded: Bool = false
    @Published var mark: Int = 0
    
    init(movie: Movie) {
        guard let repository = Injection.shared.container.resolve(MovieRepository.self) else {
            return
        }
        self.repository = repository
        guard let movie = repository.findByKinopoisId(id: movie.id) else { return }
        self.isAded = true
        self.movie = movie
        self.mark = getMark()
    }
    
    func saveMark(movie: Movie) {
        self.repository?.updateMark(id: movie.id, mark: self.mark)
    }
    
    func saveMovie(movie: Movie) {
        self.repository?.create(movie: movie, rating: self.mark)
    }
    
    func getMark() -> Int {
        self.movie.rating
    }
    
}
