//
//  DetailViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    @Published var movie: MovieEntity
    @Published var isAded: Bool = false
    @Published var mark: Int = 0
    @Published var isLogined: Bool = !UserToken.token.isEmpty
    @Published var isFavorite: Bool = false
    private var repository: Repository
    
    init(movie: Movie) {
        guard let repository = Injection.shared.container.resolve(Repository.self) else {
            fatalError("Dependency Injection failed for MovieRepository")
        }
        self.repository = repository
        self.movie = repository.toMovieEntity(movie: movie)
        guard let movieEntity = repository.findByKinopoisId(id: self.movie.kinopoiskId) else { return }
        self.movie = movieEntity
        self.isAded = true
        self.mark = getMark()
        self.isFavorite = getIsFavorite()
    }
    
    func updateMovie() {
        if self.mark != 0, self.isAded {
            self.repository.update(movie: self.movie, mark: self.mark, isFavorite: self.isFavorite)
        }
    }
    
    func deleteMovie() {
        if self.mark == 0, self.isAded, !self.isFavorite {
            self.repository.delete(movie: self.movie)
        }
    }
    
    func saveMovie() {
        if (self.mark != 0 || self.isFavorite), self.isLogined {
            self.movie.mark = self.mark
            self.movie.isFavorite = self.isFavorite
            self.repository.create(movie: self.movie)
        }
    }
    
    func getMark() -> Int {
       return self.movie.mark
    }
    
    func getIsFavorite() -> Bool {
       return self.movie.isFavorite
    }
}
