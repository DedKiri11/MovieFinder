//
//  UserDTO.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 26.07.2024.
//

import Foundation

class UserDTO {
    var login: String
    var password: String
    var name: String
    
    init(login: String, password: String, name: String) {
        self.login = login
        self.password = password
        self.name = name
    }
}
