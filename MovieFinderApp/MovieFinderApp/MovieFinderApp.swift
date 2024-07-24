//
//  MovieFinderAppApp.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI

@main
struct MovieFinderAppApp: App {
    @State private var model = MovieViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .preferredColorScheme(.dark)
        }
    }
}
