//
//  StarsMark.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct StarsMark: View {
    let maxRating = 5
    @State private var rotation: Double = 0
    @Binding var mark: Int
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) {number in
                Image(systemName: number <= mark ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(rotation))
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.5)) {
                            mark = number
                        }
                            withAnimation(.spring(duration: 1)) {
                                rotation += 360
                            }
                    }
                    .padding(.trailing)
            }
        }
    }
}

#Preview {
    StarsMark(mark: .constant(4))
}
