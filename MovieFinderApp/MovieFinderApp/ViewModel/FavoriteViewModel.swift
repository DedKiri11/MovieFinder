//
//  IsFavoriteViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//
import Combine
import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var isFavoriteMovies: [Movie] = []
    private var repository: Repository
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        guard let repository = Injection.shared.container.resolve(Repository.self) else {
            fatalError("Dependency Injection failed for IsFavoriteMovieRepository")
        }
        self.repository = repository
        bindRepository()
    }
    
    private func bindRepository() {
        repository.objectsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] objects in
                self?.isFavoriteMovies = objects.compactMap { entity in
                    self?.repository.toMovie(movie: entity)
                }
            }
            .store(in: &cancellables)
    }
}
