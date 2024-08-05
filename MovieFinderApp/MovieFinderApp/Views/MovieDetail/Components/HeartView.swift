//
//  IsFavoriteHeart.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 01.08.2024.
//

import SwiftUI

struct HeartView: View {
    @Binding var isFavorite: Bool
    @State var scale: CGFloat = 1.0
    var body: some View {
        VStack {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .scaleEffect(scale)
                .frame(width: 70, height: 70)
                .onTapGesture {
                    isFavorite.toggle()
                    withAnimation(.bouncy(duration: 0.5)) {
                        scale = isFavorite ? 2.0 : 1.0
                    }
            }
                .onAppear {
                    withAnimation(.bouncy(duration: 0.5)) {
                        scale = isFavorite ? 2.0 : 1.0
                    }
                }
        }
        .padding(.leading)
    }
}

#Preview {
    HeartView(isFavorite: .constant(true))
}
