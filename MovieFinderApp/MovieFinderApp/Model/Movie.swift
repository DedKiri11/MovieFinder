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
    
    static let `default` = Movie(id: 263531,
                                 name: .defaultMovieName,
                                 nameOriginal: .defaultMovieOrigName,
                                 genres: [ Genre(genre: .defaultMovieGenre) ],
                                 posterUrl: .defaultMoviePoster,
                                 posterUrlPreview: .defaultMoviePreviewPoster,
                                 description: .defaultMovieDescription,
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
