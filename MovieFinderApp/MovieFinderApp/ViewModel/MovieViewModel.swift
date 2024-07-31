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
    var responseData: [Movie] = []
    @Published var searchResponse = ""
    var cancelables = Set<AnyCancellable>()
    private var service: MovieDataService?
    private var currentPage = 1
    @Published var isLoadMore = false
    @Published var isEnd = false
    
    init() {
        guard let service = Injection.shared.container.resolve(MovieDataService.self) else {
            return
        }
        self.service = service
        loadSubscribe()
        load(with: self.getDefaultQuery())
    }
    
    func loadSubscribe() {
        service?.getData()
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] movies in
                self?.responseData = movies
                self?.movies.append(contentsOf: self?.responseData ?? [])
            }
            .store(in: &cancelables)
    }
    
    func load(with params: [String : String] = [:]) {
        service?.fetchData(with: params, method: .load)
    }
    
    func loadMoreItems() {
        guard let totalPages = self.service?.totalPages else { return }
        if self.currentPage <= totalPages {
            self.currentPage += 1
            print(self.currentPage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.load(with: self.getDefaultQuery())
            }
            self.isLoadMore = false
        } else {
            isEnd = true
        }
    }
    
    func cancelSearch() {
        self.responseData = []
        self.movies = self.responseData
        load(with: self.getDefaultQuery())
    }
    
    func search() {
        self.currentPage = 1
        self.service?.fetchData(with: self.getSearchQuery(), method: .search)
    }
    
    func getDefaultQuery() -> [String: String] {
        return ["type": "TOP_250_MOVIES", "page": "\(self.currentPage)"]
    }
    
    func getSearchQuery() -> [String: String] {
        return ["keyword": self.searchResponse, "page": "\(self.currentPage)"]
    }
}
