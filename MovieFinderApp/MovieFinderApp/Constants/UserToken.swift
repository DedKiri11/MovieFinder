//
//  UserToken.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 31.07.2024.
//

import Foundation

struct UserToken {
    static var token: String = UserDefaults.standard.value(forKey: "userToken") as? String ?? Constants.emptyString
}
