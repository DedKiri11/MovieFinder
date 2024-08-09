//
//  EditViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import Foundation
import Combine

class EditViewModel: ObservableObject {
    private var cancelables = Set<AnyCancellable>()
    @Published var movie: Movie
    @Published var name: String = ""
    @Published var selectedImage: URL?
    @Published var description: String = ""
    @Published var year: Int = 2024
    @Published var isValidName: Bool = false
    @Published var isPosterExist: Bool = false
    @Published var canSubmit: Bool = false
    private var repository: CustomMovieRepository

    init(repository: CustomMovieRepository) {
        self.repository = repository
        self.movie = Movie(id: 1, posterUrl: "", year: 2024)
        $name
            .receive(on: RunLoop.main)
            .map { name in
                return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            .assign(to: \.isValidName, on: self)
            .store(in: &cancelables)
        $selectedImage
            .receive(on: RunLoop.main)
            .map { selectedImage in
                guard let imageIsExist = selectedImage else { return false }
                return true
            }
            .assign(to: \.isPosterExist, on: self)
            .store(in: &cancelables)
        Publishers.CombineLatest($isValidName, $isPosterExist)
            .receive(on: RunLoop.main)
            .map { isValidName, isPosterExist in
                print("\(isValidName)  \(isPosterExist)")
                return (isValidName && isPosterExist)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancelables)
    }

    func create() {
        repository.create(movie: CustomMovieEntity(
            name: self.name,
            posterUrl: self.selectedImage?.absoluteString ?? "",
            movieDescription: self.description,
            year: self.year,
            ownerId: UserToken.token)
        )
    }
}
