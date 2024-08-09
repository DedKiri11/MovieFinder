//
//  Injection.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 26.07.2024.
//

import Foundation
import Swinject

final class Injection {
    static let shared = Injection()
    var container: Container {
        get {
            if _container == nil {
                _container = builContainer()
            }
            return _container!
        }
        set {
            _container = newValue
        }
    }
    private var _container: Container?

    private func builContainer() -> Container {
        let container = Container()
        container.register(MovieDataService.self) { _ in
            return MovieDataService()
        }
        container.register(Repository.self) { _ in
            return MovieRepository()
        }
        container.register(StaffDataService.self) { _ in
            return StaffDataService()
        }
        container.register(CustomMovieRepository.self) { _ in
            return CustomMovieRepository()
        }
        container.register(MovieViewModel.self) { _ in
            MovieViewModel(service: Injection.shared.container.resolve(MovieDataService.self)!)
        }
        container.register(FavoriteViewModel.self) { _ in
            FavoriteViewModel(repository: Injection.shared.container.resolve(Repository.self)!)
        }
        container.register(ProfileViewModel.self) { _ in
            ProfileViewModel()
        }
        container.register(EditViewModel.self) { _ in
            EditViewModel(repository: Injection.shared.container.resolve(CustomMovieRepository.self)!)
        }
        container.register(CustomMovieViewModel.self) { _ in
            CustomMovieViewModel(repository: Injection.shared.container.resolve(CustomMovieRepository.self)!)
        }
        return container
    }
}
