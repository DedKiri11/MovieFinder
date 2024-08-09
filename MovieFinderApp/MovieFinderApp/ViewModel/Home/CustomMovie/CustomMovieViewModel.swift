//
//  CustomMovieViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import Foundation
import Combine

class CustomMovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var repository: CustomMovieRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: CustomMovieRepository) {
        self.repository = repository
        bindRepository()
    }

    private func bindRepository() {
        repository.objectsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] objects in
                self?.movies = objects.compactMap { entity in
                    self?.repository.toMovie(movie: entity)
                }
            }
            .store(in: &cancellables)
    }
}
