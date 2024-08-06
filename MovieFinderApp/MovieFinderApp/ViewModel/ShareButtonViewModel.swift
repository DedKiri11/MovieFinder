//
//  ShareButtonViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation
import UIKit

class ShareButtonViewModel {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }

    func share() -> String {
        return "https://www.kinopoisk.ru/film/\(self.movie.id)/"
    }
}
