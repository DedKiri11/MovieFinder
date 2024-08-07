//
//  Countrie.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation

struct CountryDTO: Codable, Identifiable {
    let id: Int
    let country: String?
}
