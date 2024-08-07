//
//  FilterActionButton.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 07.08.2024.
//

import SwiftUI

struct FilterActionButton: View {
    var text: LocalizedStringKey
    var action: () -> Void
    var body: some View {
        Button(
            action: { action() },
            label: {
                Text(text)
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
    }
}

#Preview {
    FilterActionButton(text: "text", action: {})
}
