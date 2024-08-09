//
//  CustomMovieEntity.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import Foundation
import RealmSwift

class CustomMovieEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var posterUrl: String
    @Persisted var movieDescription: String
    @Persisted var year: Int
    @Persisted var ownerId: String

    convenience init(name: String, posterUrl: String, movieDescription: String, year: Int, ownerId: String) {
        self.init()
        self.id = UUID().uuidString
        self.name = name
        self.posterUrl = posterUrl
        self.movieDescription = movieDescription
        self.year = year
        self.ownerId = ownerId
    }
}
