//
//  MovieRepository.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation
import RealmSwift
import Combine

class MovieRepository: Repository {
    private var notificationToken: NotificationToken?
    private var objectsSubject = PassthroughSubject<[MovieEntity], Never>()
    var objectsPublisher: AnyPublisher<[MovieEntity], Never>

    init() {
        objectsPublisher = self.objectsSubject.eraseToAnyPublisher()
        fetchObjects()
    }

    private func fetchObjects() {
        let results = RealmData.shared.realm.objects(MovieEntity.self)

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

    func delete(movie: MovieEntity) {
        guard let personToDelete = RealmData.shared.realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.id) else { return }

        do {
            try RealmData.shared.realm.write {
                RealmData.shared.realm.delete(personToDelete)
            }
        } catch {
            print("Error deleting movie: \(error.localizedDescription)")
        }
    }

    func create(movie: MovieEntity) {
        do {
            try RealmData.shared.realm.write {
                RealmData.shared.realm.add(movie)
            }
        } catch {
            print("Error creating Movie: \(error.localizedDescription)")
        }
    }

    func update(movie: MovieEntity, mark: Int, isFavorite: Bool) {
        do {
            try RealmData.shared.realm.write {
                movie.mark = mark
                movie.isFavorite = isFavorite
            }
        } catch {
            print("Error updating Movie: \(error.localizedDescription)")
        }
    }

    func toMovie(movie: MovieEntity) -> Movie? {
        guard
            let kinopoiskId = Int(movie.kinopoiskId),
            let year = Int(movie.year) else {
            return nil
        }

        let genres = movie.genres.components(separatedBy: ", ")
            .compactMap { genre in
                Genre(genre: genre)
            }
        
        return Movie(id: kinopoiskId,
                     name: movie.name,
                     nameOriginal: movie.nameOriginal,
                     genres: genres,
                     posterUrl: movie.posterUrl,
                     posterUrlPreview: movie.posterUrlPreview,
                     description: movie.movieDescription,
                     year: year,
                     isFavorite: movie.isFavorite,
                     dateOfAded: movie.dataOfCreation
        )
    }

    func toMovieEntity(movie: Movie) -> MovieEntity {
        let kinopoiskId = String(movie.id)
        let name = movie.name ?? Constants.emptyString
        let nameOriginal = movie.nameOriginal
        let genres = movie.genres?.compactMap { $0.genre }.joined(separator: ", ") ?? Constants.emptyString

        let posterUrl = movie.posterUrl
        let posterUrlPreview = movie.posterUrlPreview
        let movieDescription = movie.description
        let year = String(movie.year)

        return MovieEntity(
            kinopoiskId: kinopoiskId,
            name: name,
            nameOriginal: nameOriginal ?? Constants.emptyString,
            posterUrl: posterUrl,
            posterUrlPreview: posterUrlPreview,
            genres: genres,
            movieDescription: movieDescription ?? Constants.emptyString,
            year: year,
            mark: movie.mark,
            ownerId: UserToken.token,
            isFavorite: movie.isFavorite
        )
    }

    func findByOwnerId() -> [MovieEntity]? {
        let ownerId = UserToken.token
        return RealmData.shared.realm.objects(MovieEntity.self).filter {
            $0.ownerId == ownerId
        }
    }

    func findByKinopoisId(id: String) -> MovieEntity? {
        let ownerId = UserToken.token
        return RealmData.shared.realm.objects(MovieEntity.self).filter({
            return $0.ownerId == ownerId && $0.kinopoiskId == id
        }).first
    }

    deinit {
        notificationToken?.invalidate()
    }
}
