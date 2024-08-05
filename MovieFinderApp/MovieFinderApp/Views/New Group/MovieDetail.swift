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
                        model.updateMovie()
                        model.deleteMovie()
                    } else {
                        model.saveMovie()
                    }
                    dismiss()
                }, label: {
                    Image(.backButtonIcon)
                        .foregroundColor(.gray)
                })
            }
            .padding(.leading)
            Spacer()
            Text(name)
                .font(.title2)
                .lineLimit(Constants.lineLimit1)
                .padding(.leading, Constants.titlePaddingLeadingMovieDetail)
            Spacer()
            HeartView(isFavorite: $model.isFavorite)
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
            if model.isLogined {
                StarsMark(mark: $model.mark)
                    .padding()
            } else {
                Text("If you want to rate movies you need to log in")
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
        .scrollIndicators(.hidden)
        .padding()
    }
}

#Preview {
    MovieDetail(model: DetailViewModel(movie: Movie.default), movie: Movie.default)
}
