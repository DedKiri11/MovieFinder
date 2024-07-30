//
//  MovieViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    var cancelables = Set<AnyCancellable>()
    private var service: MovieDataService?
    
    init() {
        guard let service = Injection.shared.container.resolve(MovieDataService.self) else {
            return
        }
        self.service = service
        load()
    }
    
    func load(with params: [String: String] = ["type": "TOP_250_MOVIES", "page": ""]) {
        service?.getData(with: params)
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancelables)
    }
}
