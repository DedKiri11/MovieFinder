//
//  YearSelectorView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 07.08.2024.
//

import SwiftUI

struct YearSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedYear: Int
    let years: [Int] = Array(Constants.yearDiaposone)
    var body: some View {
        VStack {
            Text("Select year:")
                .font(.headline)
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text("\(year)").tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: Constants.pickerHeight)
            Text("Selected year: \(selectedYear)")
                .font(.title2)
                .padding()
            FilterActionButton(text: "Accept", action: { dismiss() })
        }
        .padding()
    }
}

#Preview {
    YearSelectorView(selectedYear: .constant(2000))
}
