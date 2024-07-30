//
//  MovieDataService.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 26.07.2024.
//

import Foundation
import Combine

class MovieDataService {
    static var shared = MovieDataService()
    private var data: [Movie] = []

    func getData(with params: [String : String]) -> AnyPublisher<[Movie], Error> {
        fetchData(with: params)
        return APIHelper.passthrough
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .map {
                $0.items
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchData(with params: [String : String]) {
        APIHelper.sendRequest(method: .loadMovie, params: params)
    }
}
