//
//  Repository.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 05.08.2024.
//

import Foundation
import Combine

protocol Repository {
    var objectsPublisher: AnyPublisher<[MovieEntity], Never> {get set}

    func create(movie: MovieEntity)

    func update(movie: MovieEntity, mark: Int, isFavorite: Bool)

    func findByOwnerId() -> [MovieEntity]?

    func findByKinopoisId(id: String) -> MovieEntity?

    func toMovie(movie: MovieEntity) -> Movie?

    func toMovieEntity(movie: Movie) -> MovieEntity

    func delete(movie: MovieEntity)
}
