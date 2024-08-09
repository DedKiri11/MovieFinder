//
//  EditCardView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 09.08.2024.
//

import SwiftUI

struct EditCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle.fill")
                .foregroundStyle(.fill)
            .scaledToFit()
        }
        .padding()
        .frame(width: Constants.imageWidthMovieListCard, height: Constants.imageHeightMovieListCard)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                .fill(.thinMaterial)
                .stroke(Color.secondary.gradient, lineWidth: 2)

        )
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
    }
}

#Preview {
    EditCardView()
}
