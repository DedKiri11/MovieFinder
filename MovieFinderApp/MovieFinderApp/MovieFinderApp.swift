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
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Injection.shared.container.resolve(MovieViewModel.self)!)
                .environmentObject(Injection.shared.container.resolve(FavoriteViewModel.self)!)
                .environmentObject(Injection.shared.container.resolve(ProfileViewModel.self)!)
                .preferredColorScheme(.dark)
                .edgesIgnoringSafeArea(.all)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
