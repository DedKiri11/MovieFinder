//
//  MovieEntity.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift

class MovieEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var kinopoiskId: String
    @Persisted var name: String
    @Persisted var nameOriginal: String
    @Persisted var posterUrl: String
    @Persisted var posterUrlPreview: String
    @Persisted var genres: String
    @Persisted var movieDescription: String
    @Persisted var year: String
    @Persisted var rating: Int
    @Persisted var ownerId: String
    
    convenience init(kinopoiskId: String, name: String, nameOriginal: String, posterUrl: String, posterUrlPreview: String, genres: String, movieDescription: String, year: String, rating: Int, ownerId: String) {
        self.init()
        self.kinopoiskId = kinopoiskId
        self.name = name
        self.nameOriginal = nameOriginal
        self.posterUrl = posterUrl
        self.posterUrlPreview = posterUrlPreview
        self.genres = genres
        self.movieDescription = movieDescription
        self.year = year
        self.rating = rating
        self.ownerId = ownerId
    }
}
