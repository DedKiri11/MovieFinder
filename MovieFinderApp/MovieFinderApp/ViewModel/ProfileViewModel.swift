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
    @Published var image: String?
    
    init() {
        if let token = UserDefaults.standard.value(forKey: "userToken") as? String {
            isLogin = true
            UserToken.token = token
        }
        if let name = UserDefaults.standard.value(forKey: "username") as? String {
            self.fullName = name
        }
        if let image = UserDefaults.standard.value(forKey: "userImage") as? String {
            self.image = image
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
                UserDefaults.standard.setValue(name, forKey: "username")
            }
            if let image = user.profile?.imageURL(withDimension: 320) {
                self.image = image.absoluteString
                UserDefaults.standard.setValue(image.absoluteString, forKey: "userImage")
            } else {
                self.image = nil
            }
            if let token = user.idToken?.tokenString {
                UserDefaults.standard.setValue(token, forKey: "userToken")
                UserToken.token = token
            } else {
                return
            }
        }
        self.isLogin = true
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "userImage")
        self.isLogin = false
        self.fullName = Constants.emptyString
        UserToken.token = ""
    }
}
