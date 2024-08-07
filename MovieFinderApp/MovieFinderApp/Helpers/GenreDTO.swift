//
//  Genre.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation

struct GenreDTO: Codable, Identifiable {
    let id: Int
    let genre: String?
}
