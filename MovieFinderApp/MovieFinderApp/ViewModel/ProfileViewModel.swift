//
//  AuthorizationViewModel.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 29.07.2024.
//

import Foundation
import SwiftUI
import GoogleSignIn

final class ProfileViewModel: ObservableObject {
    @Published var isLogin = false
    @Published var fullName = ""
    @Published var givenName = ""
    @Published var familyName = ""
    @Published var image: URL?
    
    init() {
        if let userToken = UserDefaults.standard.value(forKey: "userToken") as? String {
            isLogin = true
        }
    }
    
    func signInWithGoogle() {
        let signInConfig = GIDConfiguration(clientID: "553584180125-dqdatdj8t95g77brb1389grb12gb3el1.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = signInConfig
        
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { signInResult, err in
            guard err == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            if let name = user.profile?.name {
                self.fullName = name
            }
            if let givenName = user.profile?.givenName {
                self.givenName = givenName
            }
            if let familyName = user.profile?.familyName {
                self.familyName = familyName
            }
            if let image = user.profile?.imageURL(withDimension: 320) {
                self.image = image
            }
            if let token = user.idToken?.tokenString {
                UserDefaults.standard.setValue(token, forKey: "userToken")
            } else {
                return
            }
        }
        self.isLogin = true
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        UserDefaults.standard.removeObject(forKey: "userToken")
        self.isLogin = false
        self.fullName = ""
        self.givenName = ""
        self.familyName = ""
    }
    
}