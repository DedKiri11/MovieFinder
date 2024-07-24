//
//  MovieDetail.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 23.07.2024.
//

import SwiftUI

private extension CGFloat {
    static let imageHeight = 400.0
    static let imageWidth = 320.0
    static let statusBackgroundWidth = 320.0
    static let statusBackgroundHeight = 42.0
    static let vStackElementsSpacing = 12.0
    static let cornerRadius = 15.0
}

struct MovieDetail: View {
    @Environment(\.dismiss) var dismiss
    var movie: Movie
    var body: some View {
        let name = (movie.name ?? movie.nameOriginal) ?? .emptyText
        HStack {
            VStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(.backButtonIcon)
                })
            }
            .padding(.leading)
            Text(name)
                .font(.title2)
                .lineLimit(1)
                .padding(.trailing)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        ScrollView(.vertical) {
            VStack {
                AsyncImage(url: URL(string: movie.posterUrl)) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
            HStack {
                Text(.relizeYearText + String(movie.year))
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text(verbatim: .aboutMovieTitle)
                        .font(.title3)
                        .padding(.bottom)
                    Text(verbatim: movie.description ?? .emptyText)
                        .font(.callout)
                    Spacer()
                }
                Spacer()
            }
            .background(.gray
                .opacity(0.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
        }
    }
}

#Preview {
    MovieDetail(movie: Movie.default)
}
