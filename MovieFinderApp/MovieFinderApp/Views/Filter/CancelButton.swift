//
//  CancelButton.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 07.08.2024.
//

import SwiftUI

struct CancelButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(
            action: { dismiss() },
            label: {
                Image(.crossIcon)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        )
    }
}

#Preview {
    CancelButton()
}
