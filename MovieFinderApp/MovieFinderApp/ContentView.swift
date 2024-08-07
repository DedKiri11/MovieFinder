//
//  ContentView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                MovieList()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                FavoritesList()
                    .tabItem {
                        Label("List", systemImage: "list.and.film")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
