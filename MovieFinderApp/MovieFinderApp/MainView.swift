//
//  ContentView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI
import GoogleSignIn

struct MainView: View {
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
    MainView()
        .environmentObject(MovieViewModel(service: MovieDataService()))
        .environmentObject(ProfileViewModel())
        .environmentObject(FavoriteViewModel(repository: MovieRepository()))
}
