//
//  MovieDetail.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 23.07.2024.
//

import SwiftUI

struct MovieDetail: View {
    let maxRating = Constants.maxMark
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    @StateObject var model: DetailViewModel
    var movie: Movie { model.movie }
    var body: some View {
        let name = (movie.name ?? movie.nameOriginal) ?? Constants.emptyString
        NavigationStack {
            ZStack {
                NavigationSwipeView(movie: movie)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zIndex(1.0)
                ScrollView(.vertical) {
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
                    .zIndex(0)
                    VStack {
                        AsyncImageView(imageURL: movie.posterUrl)
                            .scaledToFill()
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
                    StaffList(model: StaffViewModel(id: Int(model.movieEntity.kinopoiskId) ?? 0))
                        .padding(.top)
                }
                .scrollIndicators(.hidden)
                .padding()
            }
            .zIndex(0)
            .offset(y: dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        if value.translation.width > 50 {
                            dismiss()
                        }
                    }
            )
        }
    }
}

#Preview {
    MovieDetail(model: DetailViewModel(movie: Movie.default, repository: MovieRepository()))
}
