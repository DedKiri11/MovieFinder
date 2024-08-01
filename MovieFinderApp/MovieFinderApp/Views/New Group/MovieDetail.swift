//
//  MovieDetail.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 23.07.2024.
//

import SwiftUI

struct MovieDetail: View {
    let maxRating = 5
    @Environment(\.dismiss) var dismiss
    @StateObject var model: DetailViewModel
    var movie: Movie
    var body: some View {
        let name = (movie.name ?? movie.nameOriginal) ?? Constants.emptyString
        HStack {
            VStack {
                Button(action: {
                    if model.isAded {
                            model.saveMark(movie: movie)
                    } else {
                        if model.mark != 0 {
                            model.saveMovie(movie: movie)
                        }
                    }
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
                ForEach(1...maxRating, id: \.self) {number in
                    Image(systemName: number <= model.mark ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                model.mark = number
                            }
                        }
                }
            }
            HStack {
                Spacer()
                VStack {
                    Text("About")
                        .font(.title3)
                        .padding()
                    Text(movie.description ?? Constants.emptyString)
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
        .padding()
    }
}

#Preview {
    MovieDetail(model: DetailViewModel(movie: Movie.default), movie: Movie.default)
}
