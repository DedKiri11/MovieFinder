//
//  FiltersDTO.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation

struct FiltersDTO: Codable {
    let genres: [GenreDTO]
    let countries: [CountryDTO]
}
