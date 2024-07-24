//
//  ContentView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MovieList()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(MovieViewModel())
}
