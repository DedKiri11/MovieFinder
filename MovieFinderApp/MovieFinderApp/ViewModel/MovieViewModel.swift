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
    private var currentPage = 1
    @Published var isLoadMore = false
    
    init() {
        guard let service = Injection.shared.container.resolve(MovieDataService.self) else {
            return
        }
        self.service = service
        if !isLoadMore {
            load()
        } else {
            isLoadMore = false
        }
    }
    
    func load(with params: [String: String] = ["type": "TOP_250_MOVIES", "page": ""]) {
        service?.getData(with: params)
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies)
            }
            .store(in: &cancelables)
    }
    
    func loadMoreItems() {
        guard let totalPages = self.service?.totalPages else { return }
        if self.currentPage <= totalPages {
            self.currentPage += 1
            print(self.currentPage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.service?.fetchData(with: ["type": "TOP_250_MOVIES", "page": "\(self.currentPage)"])
                self.isLoadMore = false
            }
        }
    }
}
