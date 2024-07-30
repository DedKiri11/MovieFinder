//
//  MovieDetail.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 23.07.2024.
//

import SwiftUI

struct MovieDetail: View {
    @Environment(\.dismiss) var dismiss
    var movie: Movie
    var body: some View {
        let name = (movie.name ?? movie.nameOriginal) ?? Constants.emptyText
        HStack {
            VStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(.backButtonIcon)
                        .foregroundColor(.gray)
                })
            }
            .padding(.leading)
            Text(name)
                .font(.title2)
                .lineLimit(Constants.lineLimit1)
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
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
            HStack {
                Text("Relize year: \(movie.year)")
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text("About")
                        .font(.title3)
                        .padding()
                    Text(movie.description ?? Constants.emptyText)
                        .font(.callout)
                    Spacer()
                }
                Spacer()
            }
            .background(.gray
                .opacity(Constants.aboutMovieBackgroundOpacity)
            )
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
        }
    }
}

#Preview {
    MovieDetail(movie: Movie.default)
}
