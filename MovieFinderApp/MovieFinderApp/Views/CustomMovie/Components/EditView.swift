//
//  EditView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: EditViewModel
    @State private var shakeAnimation = false
    @State var showYearPicker = false

    var body: some View {
        ScrollView {
            EditPosterView(selectedImage: $model.selectedImage)
            EditMovieTextField(text: $model.name, title: "Name of movie", prompt: "Name")
            VStack(alignment: .leading) {
                Text("Description")
                TextEditor(text: $model.description)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                    .padding()
                    .frame(height: Constants.textEditorHeight)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                            .fill(.thinMaterial)
                    )
            }
            .padding()
            HStack {
                Text("Selected year: \(model.year)")
                Button("Select year") {
                    showYearPicker.toggle()
                }
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                        .fill(.thinMaterial)
                        .stroke(Color.secondary.gradient, lineWidth: 2)
                )
                .sheet(isPresented: $showYearPicker) {
                    YearSelectorView(selectedYear: $model.year)
                        .presentationDetents([.height(Constants.yearSelectorSheetHeight)])
                        .presentationCornerRadius(Constants.cornerRadius50)
                }
            }
            Button("Accept") {
                if model.canSubmit {
                    model.create()
                    dismiss()
                } else {
                    shakeAnimation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        shakeAnimation = false
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                    .fill(.thinMaterial)
                    .stroke(Color.secondary.gradient, lineWidth: 2)
            )
            .scaleEffect(shakeAnimation ? 1.1 : 1.0)
            .animation(
                Animation.default.repeatCount(5, autoreverses: true).speed(2),
                value: shakeAnimation
            )
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}
#Preview {
    EditView()
}
