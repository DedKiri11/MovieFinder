//
//  MovieViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import Foundation
import UIKit

@Observable
class MovieViewModel {
    var movies: [Movie] = []

    init() {
        APIHelper.passthrough.sink { data in
            let decoder = JSONDecoder()

            guard let decodedData = try? decoder.decode(MovieResponse.self, from: data) else { return }

            self.movies = decodedData.items

        }.store(in: &APIHelper.canсellables)

        load()
    }

    func load() {
        APIHelper.sendRequest(method: .loadMovie, params: ["type": "TOP_POPULAR_ALL", "page": ""])
    }

}
