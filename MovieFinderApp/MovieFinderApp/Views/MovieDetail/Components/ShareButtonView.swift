//
//  ShareButtonView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct ShareButtonView: View {
    var movie: Movie
    @Binding var isActive: Bool
    var model: ShareButtonViewModel {
        ShareButtonViewModel(movie: movie)
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                    .sheet(isPresented: $isActive) {
                        ShareView(items: [model.share()])
                    }
            }
        }
    }
}

#Preview {
    ShareButtonView(movie: Movie.default, isActive: .constant(false))
}
