//
//  DateFilterView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 05.08.2024.
//

import SwiftUI

struct DateFilterView: View {
    @Binding var isLatest: Bool
    var action: () -> Void
    @State var rotation = 0.0
    var body: some View {
        HStack {
            Text("Date")
            Image(systemName: "arrow.up")
                .rotationEffect(Angle.degrees(rotation))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius15)
                .fill(Color.gray
                    .opacity(Constants.opacity02)
                )
            )
        .onTapGesture {
            isLatest.toggle()
            action()
            withAnimation(.bouncy(duration: 0.5)) {
                rotation += 180
            }
        }
    }
}

#Preview {
    DateFilterView(isLatest: .constant(true), action: {})
}
