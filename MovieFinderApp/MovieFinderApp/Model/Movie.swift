//
//  Movie.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import Foundation

struct Genre: Codable {
    let genre: String?
}

struct Movie: Codable, Identifiable, Hashable {
    var id: Int
    var name: String?
    var nameOriginal: String?
    var genres: [Genre]?
    var posterUrl: String
    var posterUrlPreview: String
    var description: String?
    var year: Int
    var isFavorite: Bool = false
    var mark: Int = 0
    var dateOfAded: Date = Date()

    static let `default` = Movie(id: 263531,
                                 name: "Матрица",
                                 nameOriginal: "Matrix",
                                 genres: [ Genre(genre: "фантастика") ],
                                 posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/5089025.jpg",
                                 posterUrlPreview: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/5089025.jpg",
                                 description: "Lorem Imsum Lorem Imsum Lorem Imsum Lorem Imsum Lorem Imsum рыба короче",
                                 year: 2021
    )

    enum CodingKeys: String, CodingKey {
        case id = "kinopoiskId"
        case name = "nameRu"
        case nameOriginal = "nameOriginal"
        case genres = "genres"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
        case description = "description"
        case year = "year"
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
