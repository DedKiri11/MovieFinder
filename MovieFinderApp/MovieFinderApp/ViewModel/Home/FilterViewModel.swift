//
//  FilterViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation
import Combine

class FilterViewModel: ObservableObject {
    @Published var genres: [GenreDTO] = []
    @Published var countries: [CountryDTO] = []
    @Published var filterQuery: [String : String] = [:]
    @Published var selectedCountryId: Int = 0
    @Published var selectedGenreId: Int = 0
    @Published var relizeYear: Int = 0
    var cancelables = Set<AnyCancellable>()
    private var service: MovieDataService

    init() {
        guard let service = Injection.shared.container.resolve(MovieDataService.self) else {
            fatalError("Dependency Injection failed for MovieDataService")
        }
        self.service = service
        fetchFilters()
    }

    func fetchFilters() {
        service.getFilterData()
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] filters in
                self?.countries = filters.countries
                self?.genres = filters.genres
            }
            .store(in: &cancelables)
    }

    func getQuery() -> [String : String] {
        var query: [String : String] = [:]
        if selectedCountryId != 0 {
            let string = String(self.countries.filter { $0.id == selectedCountryId }.first!.id)
            query["countries"] = "\(string)"
        }
        if selectedGenreId != 0 {
            let string = String(self.genres.filter { $0.id == selectedGenreId }.first!.id)
            query["genres"] = "\(string)"
        }
        if relizeYear != 0 {
            query["yearFrom"] = String(self.relizeYear)
            query["yearTo"] = String(self.relizeYear)
        }
        return query
    }

    func getSearchedCountries(query: String) -> [CountryDTO] {
        return self.countries.filter { $0.country!.localizedCaseInsensitiveContains(query) }
    }

    func getSearchedGenres(query: String) -> [GenreDTO] {
        return self.genres.filter { $0.genre!.localizedCaseInsensitiveContains(query) }
    }
}
