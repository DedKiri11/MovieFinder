//
//  CustomMovieRepository.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import Foundation
import Combine
import RealmSwift

class CustomMovieRepository {
    private var notificationToken: NotificationToken?
    private var objectsSubject = PassthroughSubject<[CustomMovieEntity], Never>()
    var objectsPublisher: AnyPublisher<[CustomMovieEntity], Never>

    init() {
        objectsPublisher = self.objectsSubject.eraseToAnyPublisher()
        fetchObjects()
    }

    private func fetchObjects() {
        let results = RealmData.shared.realm.objects(CustomMovieEntity.self)

        notificationToken = results.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.objectsSubject.send(Array(self?.findByOwnerId() ?? []))
            case .update(_, let deletions, _, _):
                var currentObjects = Array(self?.findByOwnerId() ?? [])
                currentObjects.remove(atOffsets: IndexSet(deletions))
                self?.objectsSubject.send(currentObjects)
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func create(movie: CustomMovieEntity) {
        do {
            try RealmData.shared.realm.write {
                RealmData.shared.realm.add(movie)
            }
        } catch {
            print("Error creating Movie: \(error.localizedDescription)")
        }
    }

    func toMovie(movie: CustomMovieEntity) -> Movie? {
        return Movie(id: 1,
                     name: movie.name,
                     nameOriginal: "",
                     genres: [],
                     posterUrl: movie.posterUrl,
                     posterUrlPreview: "",
                     description: movie.movieDescription,
                     year: movie.year,
                     isFavorite: false,
                     dateOfAded: Date()
        )
    }

    func findByOwnerId() -> [CustomMovieEntity]? {
        let ownerId = UserToken.token
        return RealmData.shared.realm.objects(CustomMovieEntity.self).filter {
            $0.ownerId == ownerId
        }
    }
}
