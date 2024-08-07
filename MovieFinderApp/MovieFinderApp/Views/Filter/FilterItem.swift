//
//  FilterItem.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct FilterItem: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                    .fill(Color.white)
                    .stroke(Color.gray , lineWidth: 1.0)
            )
    }
}

#Preview {
    FilterItem(text: "Cuckaracha")
}
