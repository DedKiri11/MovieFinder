//
//  StaffDataService.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation
import Combine

class StaffDataService {
    func getDataAboutStaff(with params: [String : String]) -> AnyPublisher<[Staff], Error> {
        return APIHelper.sendRequest(method: .loadStaff, for: .staff, params: params)
            .decode(type: [Staff].self, decoder: JSONDecoder())
            .flatMap { staff -> Future<[Staff], Error> in
                return Future<[Staff], Error> { promise in
                    promise(.success(staff))
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
