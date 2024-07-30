//
//  AuthorizationView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 24.07.2024.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct ProfileView: View {
    @StateObject var model = ProfileViewModel()
    @State var alertColor = Color.gray
    var body: some View {
        if !model.isLogin {
            VStack(alignment: .center) {
                Text("Entry")
                    .font(.title)
                    .padding(.bottom)
                Spacer()
                VStack {
                    AuthorizationButton(action: model.signInWithGoogle, buttonText: "Sign in with Google", backgroundColor: Color.white, image: "GoogleIcon")
                    Text("")
                }
                Spacer()
            }
            .padding()
        } else {
            AuthorizationButton(action: model.signOut, buttonText: "Log out", backgroundColor: Color.black, image: "BackButtonIcon")
        }
    }
}

#Preview {
    ProfileView()
}
