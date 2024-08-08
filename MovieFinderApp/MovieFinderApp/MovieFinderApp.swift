//
//  MovieFinderAppApp.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//

import SwiftUI
import GoogleSignIn
import Swinject

@main
struct MovieFinderAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let container = Container()
    
    init() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        container.register(MovieViewModel.self) { _ in
            MovieViewModel(service: Injection.shared.container.resolve(MovieDataService.self)!)
        }
        container.register(FavoriteViewModel.self) { _ in
            FavoriteViewModel(repository: Injection.shared.container.resolve(Repository.self)!)
        }
        container.register(ProfileViewModel.self) { _ in
            ProfileViewModel()
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container.resolve(MovieViewModel.self)!)
                .environmentObject(container.resolve(FavoriteViewModel.self)!)
                .environmentObject(container.resolve(ProfileViewModel.self)!)
                .preferredColorScheme(.dark)
                .edgesIgnoringSafeArea(.all)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
