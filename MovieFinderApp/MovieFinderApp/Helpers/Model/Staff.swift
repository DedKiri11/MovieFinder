//
//  Staff.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation

struct Staff: Codable, Identifiable, Hashable {
    var id: Int
    var nameRu: String?
    var nameEn: String?
    var description: String?
    var posterUrl: String?
    var professionText: String?
    var professionKey: String?

    static let `default` = Staff(id: 1,
                                 nameRu: "Винс Гиллиган",
                                 nameEn: "Vince Gilligan",
                                 description: "Neo",
                                 posterUrl: "https://st.kp.yandex.net/images/actor/66539.jpg",
                                 professionText: "Режиссеры",
                                 professionKey: "DIRECTOR")

    static func == (lhs: Staff, rhs: Staff) -> Bool {
        return lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id = "staffId"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case description = "description"
        case posterUrl = "posterUrl"
        case professionText = "professionText"
        case professionKey = "professionKey"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
