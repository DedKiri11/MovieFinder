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
        
        return container
    }
}
