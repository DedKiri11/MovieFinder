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

    static let `default` = Movie(id: 263531,
                                 name: "Матрица",
                                 nameOriginal: "The Matrix",
                                 genres: [ Genre(genre: "фантастика") ],
                                 posterUrl: "http://kinopoiskapiunofficial.tech/images/posters/kp/263531.jpg",
                                 posterUrlPreview: "https://kinopoiskapiunofficial.tech/images/posters/kp_small/301.jpg")

    enum CodingKeys: String, CodingKey {
        case id = "kinopoiskId"
        case name = "nameRu"
        case nameOriginal = "nameOriginal"
        case genres = "genres"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

}
