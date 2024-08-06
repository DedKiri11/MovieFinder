//
//  MovieDataService.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 26.07.2024.
//

import Foundation
import Combine

class MovieDataService {
    var totalPages = 0
    
    func getData(with params: [String : String]) -> AnyPublisher<[Movie], Error> {
        return self.sendRequest(method: .loadMovie, params: params)
    }
    
    func getDataForSearch(with params: [String : String]) -> AnyPublisher<[Movie], Error> {
        return self.sendRequest(method: .searchMovie, params: params)
    }
    
    func sendRequest(method: APIHelper.APIMethods, params: [String : String]) -> AnyPublisher<[Movie], Error> {
        APIHelper.sendRequest(method: method, for: .movie, params: params)
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .flatMap { movieDTO -> Future<[Movie], Error> in
                self.totalPages = movieDTO.totalPages
                return Future<[Movie], Error> { promise in
                    promise(.success(movieDTO.items))
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
