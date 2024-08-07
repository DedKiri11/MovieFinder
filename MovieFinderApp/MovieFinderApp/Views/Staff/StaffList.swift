//
//  StaffList.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct StaffList: View {
    @StateObject var model: StaffViewModel
    var body: some View {
        VStack {
            Text("Director")
                .font(.title)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(model.directors, id: \.self) { staff in
                        StaffCard(staff: staff)
                    }
                }
            }
            .scrollIndicators(.hidden)
            Text("Cast")
                .font(.title)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(model.actors, id: \.self) { staff in
                        StaffCard(staff: staff)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    StaffList(model: StaffViewModel(id: 263531))
}
