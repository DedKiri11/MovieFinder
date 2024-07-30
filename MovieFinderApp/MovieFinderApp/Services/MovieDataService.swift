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
    
    func getData(with params: [String : String]) -> AnyPublisher<[Movie], Error> {
        fetchData(with: params)
        return APIHelper.passthrough
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .tryMap { movieDTO -> [Movie] in
                self.totalPages = movieDTO.totalPages
                return movieDTO.items
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchData(with params: [String : String]) {
        APIHelper.sendRequest(method: .loadMovie, params: params)
    }
}
