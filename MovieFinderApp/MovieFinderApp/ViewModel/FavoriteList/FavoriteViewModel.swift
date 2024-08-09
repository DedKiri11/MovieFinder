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
    @Published var isLatest: Bool = true
    private var repository: Repository
    private var cancellables = Set<AnyCancellable>()

    init(repository: Repository) {
        self.repository = repository
        bindRepository()
    }

    func filterByDate() {
        if self.isLatest {
            self.isFavoriteMovies = self.isFavoriteMovies.sorted {
                $0.dateOfAded < $1.dateOfAded
            }
        } else {
            self.isFavoriteMovies = self.isFavoriteMovies.sorted {
                $0.dateOfAded > $1.dateOfAded
            }
        }
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
