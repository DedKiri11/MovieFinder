//
//  StaffViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import Foundation
import Combine

class StaffViewModel: ObservableObject {
    @Published var actors: [Staff] = []
    @Published var directors: [Staff] = []
    var cancelables = Set<AnyCancellable>()
    private var service: StaffDataService
    
    enum ProffessionKey: String {
        case actor = "ACTOR"
        case director = "DIRECTOR"
    }
    
    init(id: Int) {
        guard let service = Injection.shared.container.resolve(StaffDataService.self) else {
            fatalError("Dependency Injection failed for MovieDataService")
        }
        self.service = service
        fetchStaff(id: id)
    }
    
    func fetchStaff(id: Int) {
        service.getDataAboutStaff(with: ["filmId" : "\(id)"])
            .sink { camplition in
                print(camplition)
            } receiveValue: { [weak self] staff in
                self?.actors = staff.filter {
                    $0.professionKey == ProffessionKey.actor.rawValue
                }
                self?.directors = staff.filter {
                    $0.professionKey == ProffessionKey.director.rawValue
                }
            }
            .store(in: &cancelables)
    }
}
