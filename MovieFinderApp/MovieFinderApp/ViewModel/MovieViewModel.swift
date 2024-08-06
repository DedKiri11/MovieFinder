//
//  MovieViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import Foundation
import Combine
import RealmSwift

class MovieViewModel: ObservableObject {
    @Published var loadMovies: [Movie] = []
    @Published var searchMovies: [Movie] = []
    @Published var movies: [Movie] = []
    @Published var searchQuery = ""
    var cancelables = Set<AnyCancellable>()
    private var service: MovieDataService
    private var currentPage = 1
    @Published var isLoadMore = false
    @Published var isEnd = false
    
    init() {
        guard let service = Injection.shared.container.resolve(MovieDataService.self) else {
            fatalError("Dependency Injection failed for MovieDataService")
        }
        self.service = service
        fetchMovies()
        load()
    }
    
    func fetchMovies() {
        service.getData(with: getDefaultQuery())
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] movies in
                self?.loadMovies.append(contentsOf: movies)
                self?.load()
            }
            .store(in: &cancelables)
    }
    
    func fetchSearchMovies() {
        service.getDataForSearch(with: getSearchQuery())
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] movies in
                self?.searchMovies = movies
                self?.loadSearch()
            }
            .store(in: &cancelables)
    }
    
    func load() {
        movies = loadMovies
    }
    
    func loadSearch() {
        movies = searchMovies
    }
    
    func loadMoreItems() {
        let totalPages = self.service.totalPages
        if self.currentPage <= totalPages {
            self.currentPage += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fetchMovies()
            }
            self.isLoadMore = false
        } else {
            isEnd = true
        }
    }
    
    func cancelSearch() {
        self.movies = self.loadMovies
    }
    
    
    func search() {
       fetchSearchMovies()
    }
    
    func getDefaultQuery() -> [String: String] {
        return ["type": "TOP_250_MOVIES", "page": "\(self.currentPage)"]
    }
    
    func getSearchQuery() -> [String: String] {
        return ["keyword": self.searchQuery, "page": "1"]
    }
}
