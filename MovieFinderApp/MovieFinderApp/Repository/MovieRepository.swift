//
//  MovieRepository.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift

class MovieRepository {
    let realm = try! Realm()
    
    func create(movie: Movie, rating: Int) {
        let movie = toMoveEntity(movie: movie, rating: rating)
        try! realm.write {
            realm.add(movie)
        }
    }
    
    func updateMark(id: Int, mark: Int) {
        guard let movie = findByKinopoisId(id: id) else { return }
        
        try! realm.write {
            movie.rating = mark
        }
    }
    
    func findByOwnerId() -> [MovieEntity]? {
        let ownerId = UserToken.token
        return realm.objects(MovieEntity.self).filter {
            $0.ownerId == ownerId
        }
    }
    
    func findByKinopoisId(id: Int) -> MovieEntity? {
        let ownerId = UserToken.token
        return realm.objects(MovieEntity.self).filter({
           return $0.ownerId == ownerId && $0.kinopoiskId == String(id)
        }).first
    }
    
    func toMoveEntity(movie: Movie, rating: Int) -> MovieEntity {
        MovieEntity(
            kinopoiskId: String(movie.id),
            name: movie.name ?? "",
            nameOriginal: movie.name ?? "",
            posterUrl: movie.name ?? "",
            posterUrlPreview: movie.name ?? "",
            genres: movie.genres?.compactMap({ genre in
                genre.genre
            }).joined(separator: ", ") ?? "",
            movieDescription: movie.name ?? "",
            year: movie.name ?? "",
            rating: rating,
            ownerId: UserDefaults.standard.value(forKey: "userToken") as! String
        )
    }
}
