//
//  FilterButtonView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct FilterButtonList: View {
    @State var activeButtonIndex: Int = -1
    @Binding var currentId: Int
    var filterNames: [(String, Int)]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Constants.filterButtonListSpacing) {
                ForEach(filterNames.indices, id: \.self) { index in
                    Button(action: {
                        if activeButtonIndex == index {
                            activeButtonIndex = -1
                        } else {
                            currentId = filterNames[index].1
                            activeButtonIndex = index
                        }
                    }, label: {
                        FilterItem(text: filterNames[index].0)
                            .opacity(activeButtonIndex == -1 || activeButtonIndex == index ? Constants.opacity1 : Constants.opacity05)
                    })
                    .disabled(activeButtonIndex != -1 && activeButtonIndex != index)
                }
            }
            .padding()
            .padding(.bottom)
        }
        .scrollIndicators(.hidden)
    }
}
