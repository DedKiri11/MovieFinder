//
//  MovieDataService.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 26.07.2024.
//

import Foundation
import Combine

class MovieDataService {
    private var data: [Movie] = []
    private var canсellables: Set<AnyCancellable> = []
    var totalPages = 0
    
     enum FetchMethod: String {
        case load = "loadMovie"
        case search = "searchMovie"
    }
    
    func getData() -> AnyPublisher<[Movie], Error> {
        return APIHelper.passthrough
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .tryMap { movieDTO -> [Movie] in
                self.totalPages = movieDTO.totalPages
                return movieDTO.items
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchData(with params: [String : String], method: FetchMethod) {
        switch method {
        case .search:
            APIHelper.sendRequest(method: .searchMovie, params: params)
        default:
            APIHelper.sendRequest(method: .loadMovie, params: params)
        }
    }
}
