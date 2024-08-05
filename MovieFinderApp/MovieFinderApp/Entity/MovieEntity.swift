//
//  MovieEntity.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift

class MovieEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var kinopoiskId: String
    @Persisted var name: String
    @Persisted var nameOriginal: String
    @Persisted var posterUrl: String
    @Persisted var posterUrlPreview: String
    @Persisted var genres: String
    @Persisted var movieDescription: String
    @Persisted var year: String
    @Persisted var mark: Int
    @Persisted var isFavorite: Bool
    @Persisted var ownerId: String
    @Persisted var dataOfCreation: Date
    
    convenience init(kinopoiskId: String, name: String, nameOriginal: String, posterUrl: String, posterUrlPreview: String, genres: String, movieDescription: String, year: String, mark: Int, ownerId: String, isFavorite: Bool) {
        self.init()
        self.id = UUID().uuidString
        self.kinopoiskId = kinopoiskId
        self.name = name
        self.nameOriginal = nameOriginal
        self.posterUrl = posterUrl
        self.posterUrlPreview = posterUrlPreview
        self.genres = genres
        self.movieDescription = movieDescription
        self.year = year
        self.mark = mark
        self.ownerId = ownerId
        self.dataOfCreation = Date()
        self.isFavorite = isFavorite
    }
}
