//
//  MovieResponse.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import Foundation

struct MovieResponse: Codable {
    let total: Int
    let totalPages: Int
    let items: [Movie]
}
