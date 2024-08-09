//
//  ProfileCard.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 30.07.2024.
//

import SwiftUI

struct ProfileCard: View {
    var fullName: String
    var image: String?
    var logOutButton: AuthorizationButton
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Profile")
                    .font(.title)
                if let image = image {
                    AsyncImageView(imageURL: image)
                        .clipShape(Circle())
                        .frame(width: Constants.imageWidthProfileCard, height: Constants.imageHeightProfileCard)

                } else {
                    Image(.unknown)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: Constants.imageWidthProfileCard, height: Constants.imageHeightProfileCard)
                }
                Text(fullName)
                logOutButton
                    .padding(.top, Constants.paddingTopOfLogOutButton)
                Spacer()
            }
            Spacer()
        }
        .background(
            .gray
                .opacity(Constants.opacity02)
        )
    }
}

#Preview {
    ProfileCard(fullName: "Kitti", image: nil, logOutButton: AuthorizationButton(action: {}, buttonText: "Log out", backgroundColor: Color.black, image: "BackButtonIcon"))
}
