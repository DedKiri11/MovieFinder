//
//  AuthorizationButton.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 25.07.2024.
//

import SwiftUI

struct AuthorizationButton: View {
    var action: () -> Void
    var buttonText: LocalizedStringKey
    let backgroundColor: Color
    let image: String
    var body: some View {
        Button(action: action, label: {
            HStack {
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.heightOfButtonImageAuthButton, alignment: .leading)
                        .background(backgroundColor)
                }
                Text(buttonText)
                    .frame(height: Constants.heightOfButtonTextAuthButton, alignment: .leading)
                    .padding(Constants.paddingOfButtonTextAuthButton)
                    .foregroundColor(.gray)
            }
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                    .fill(backgroundColor)
            )
            .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                .stroke(Color.gray))
        })
    }
}

#Preview {
    AuthorizationButton(action: {}, buttonText: "Sign in with Google", backgroundColor: Color.white, image: "GoogleIcon")
}
