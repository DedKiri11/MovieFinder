//
//  SetUpRealm.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 05.08.2024.
//

import Foundation
import RealmSwift

class RealmData {
    var realm: Realm
    static let shared = RealmData()
    
    init() {
        var config = Realm.Configuration.defaultConfiguration
        
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("movieFinderRealm.realm")
        
        Realm.Configuration.defaultConfiguration = config
        
        print("Realm initialized with configuration: \(config)")
        
        do {
            self.realm = try Realm()
            print("Realm file path: \(realm.configuration.fileURL?.absoluteString ?? "N/A")")
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)")
        }
    }
}
