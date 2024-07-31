//
//  SearchBar.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 30.07.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSerching: Bool
    var action: () -> Void
    var cancelAction: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    Spacer()
                    Image(.searchIcon)
                        .foregroundColor(.black)
                    TextField("Search", text: $searchText,  onEditingChanged: { (isBegin) in
                        if !isBegin {
                            isSerching = true
                        }
                    })
                    .onSubmit {
                        action()
                    }
                    if isSerching {
                        Button(action: {
                            cancelAction()
                            isSerching = false
                            searchText = Constants.emptyString
                        }, label: {
                            Image(.crossIcon)
                                .resizable()
                                .frame(width: Constants.searchCancelButtonWidth, height: Constants.searchCancelButtonHeight)
                                .padding(.trailing)
                        })
                    }
                }
                .font(.caption)
                .foregroundColor(.white)
                .frame(height: Constants.searchBarHeight)
                .textFieldStyle(.plain)
                .cornerRadius(Constants.cornerRadius15)
            }
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                    .fill(.black)
                    .stroke(Color.gray, lineWidth: Constants.borderWidthSearchBar)
                    .frame(height: Constants.backgroundHeightSearchBar)
                    .opacity(Constants.opacity02)
            )
            .cornerRadius(Constants.cornerRadius15)
        }
        .frame(height: Constants.searchBarHeight)
    }
}
