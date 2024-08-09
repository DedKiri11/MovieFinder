//
//  FilterView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedYear: Int = 0
    @State private var showPicker = false
    @Binding var filterQuery: [String : String]
    @State var countrySearch: String = ""
    @State var genreSearch: String = ""
    @StateObject var model = FilterViewModel()
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CancelButton()
                    .frame(width: Constants.cancellButtonSizeFilterView, height: Constants.cancellButtonSizeFilterView)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Country")
                        .font(.headline)
                    TextField("Search country", text: $countrySearch)
                }
                var countries = countrySearch.isEmpty ? model.countries : model.getSearchedCountries(query: countrySearch)
                FilterButtonList(currentId: $model.selectedCountryId, filterNames: countries
                    .map { country in
                        return (country.country ?? Constants.emptyString, country.id)
                    }
                )
                HStack {
                    Text("Genre")
                        .font(.headline)
                    TextField("Search genre", text: $genreSearch)
                }
                let genres = genreSearch.isEmpty ? model.genres : model.getSearchedGenres(query: genreSearch)
                FilterButtonList(currentId: $model.selectedGenreId, filterNames: genres
                    .map { genre in
                        return (genre.genre ?? Constants.emptyString, genre.id)
                    }
                )
                Text("Relize year: \(model.relizeYear == 0 ? Constants.emptyString : String(model.relizeYear))")
                    .font(.headline)
                FilterActionButton(text: "Select year", action: { showPicker.toggle() })
                    .sheet(isPresented: $showPicker) {
                        YearSelectorView(selectedYear: $model.relizeYear)
                            .presentationDetents([.height(Constants.yearSelectorSheetHeight)])
                            .presentationCornerRadius(Constants.cornerRadius50)
                    }
            }
            .padding()
            .padding(.leading)
            Button(
                action: {
                    filterQuery = model.getQuery()
                    dismiss()
                },
                label: {
                    Text("Accept")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                                .fill(Color.gray
                                    .opacity(Constants.opacity02)
                                )
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                }
            )
            .padding()
        }
    }
}

#Preview {
    FilterView(filterQuery: .constant([:]))
}
