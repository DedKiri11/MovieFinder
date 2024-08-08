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
    @Published var searchQuery = Constants.emptyString
    @Published var filterQuery: [String : String] = [:]
    @Published var isLoadMore = false
    @Published var isEnd = false
    @Published var isFilter = false
    var cancelables = Set<AnyCancellable>()
    private var service: MovieDataService
    private var filterPage = 1
    private var loadPage = 1
    
    init(service: MovieDataService) {
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
    
    func fetchFilteredMovies() {
        service.getDataForSearch(with: filterQuery)
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
    
    func refresh() {
        if loadMovies.isEmpty {
            fetchMovies()
        } else {
            load()
        }
    }
    
    func loadSearch() {
        movies = searchMovies
    }
    
    func loadMoreItems() {
        let totalPages = self.service.totalPages
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isFilter {
                if self.filterPage <= totalPages {
                    self.filterPage += 1
                    self.filterQuery.merge(["page": "\(self.filterPage)"]) { _, new in new }
                    self.filter()
                } else { self.isEnd = true }
            } else {
                if self.loadPage <= totalPages {
                    self.loadPage += 1
                    self.fetchMovies()
                } else { self.isEnd = true }
            }
        }
        self.isLoadMore = false
    }
    
    func cancelSearch() {
        self.movies = self.loadMovies
        self.filterPage = 1
        self.isFilter = false
    }
    
    func filter() {
        self.isFilter = true
        if !self.searchQuery.isEmpty {
            self.filterQuery.merge(getSearchQuery()) { current, _ in current }
        }
        fetchFilteredMovies()
    }
    
    func search() {
        fetchSearchMovies()
    }
    
    func getDefaultQuery() -> [String: String] {
        return ["type": "TOP_250_MOVIES", "page": "\(self.loadPage)"]
    }
    
    func getSearchQuery() -> [String: String] {
        return ["keyword": self.searchQuery, "page": "1"]
    }
}
