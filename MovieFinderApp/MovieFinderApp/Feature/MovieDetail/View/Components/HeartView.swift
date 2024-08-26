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
                .frame(width: Constants.heartWidth, height: Constants.heartHeight)
                .onTapGesture {
                    withAnimation(.spring(duration: 0.5)) {
                        isFavorite.toggle()
                        scale = isFavorite ? Constants.scale2 : Constants.basicScale
                    }
                }
                .onAppear {
                    withAnimation(.spring(duration: 1)) {
                        scale = isFavorite ? Constants.scale2 : Constants.basicScale
                    }
                }
        }

        .padding(.leading)
    }
}

#Preview {
    HeartView(isFavorite: .constant(true))
}
