//
//  EditMovieTextField.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import SwiftUI

struct EditMovieTextField: View {
    @Binding var text: String
    var title: LocalizedStringKey
    var prompt: LocalizedStringKey
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField(prompt, text: $text)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    EditMovieTextField(text: .constant(""), title: "Title", prompt: "text")
}
