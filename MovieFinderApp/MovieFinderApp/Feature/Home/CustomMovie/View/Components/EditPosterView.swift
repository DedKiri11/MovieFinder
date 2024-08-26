//
//  EditPosterView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import SwiftUI

struct EditPosterView: View {
    @State private var showImagePicker = false
    @Binding var selectedImage: URL?

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                AsyncImage(url:  selectedImage) { image in
                    image.image?
                        .resizable()
                }
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                .frame(width: Constants.imageWidthEditView, height: Constants.imageHeightEditView)
            } else {
                Image(.unknown)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                    .frame(width: Constants.imageWidthEditView, height: Constants.imageHeightEditView)
                Text("Select poster for movie")
                    .foregroundColor(.gray)
            }
            Button("Select") {
                showImagePicker.toggle()
            }
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                    .fill(.thinMaterial)
                    .stroke(Color.secondary.gradient, lineWidth: 2)
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .padding()
    }
}
