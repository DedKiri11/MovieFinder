//
//  DetailViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    @Published var movieEntity: MovieEntity
    @Published var movie: Movie
    @Published var isAded: Bool = false
    @Published var mark: Int = 0
    @Published var isLogined: Bool = !UserToken.token.isEmpty
    @Published var isFavorite: Bool = false
    private var repository: Repository
    
    init(movie: Movie, repository: Repository) {
        self.movie = movie
        self.repository = repository
        self.movieEntity = repository.toMovieEntity(movie: movie)
        guard let movieEntity = repository.findByKinopoisId(id: self.movieEntity.kinopoiskId) else { return }
        self.movieEntity = movieEntity
        self.isAded = true
        self.mark = getMark()
        self.isFavorite = getIsFavorite()
    }
    
    func updateMovie() {
        if self.mark != 0, self.isAded {
            self.repository.update(movie: self.movieEntity, mark: self.mark, isFavorite: self.isFavorite)
        }
    }
    
    func deleteMovie() {
        if self.mark == 0, self.isAded, !self.isFavorite {
            self.repository.delete(movie: self.movieEntity)
        }
    }
    
    func saveMovie() {
        if (self.mark != 0 || self.isFavorite), self.isLogined {
            self.movieEntity.mark = self.mark
            self.movieEntity.isFavorite = self.isFavorite
            self.repository.create(movie: self.movieEntity)
        }
    }
    
    func getMark() -> Int {
        return self.movieEntity.mark
    }
    
    func getIsFavorite() -> Bool {
        return self.movieEntity.isFavorite
    }
}
