//
//  StaffCard.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct StaffCard: View {
    var staff: Staff
    var body: some View {
        VStack {
            AsyncImageView(imageURL: staff.posterUrl)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                    .scaledToFit()
            Text(staff.nameRu ?? Constants.emptyString)
            Text(staff.description ?? Constants.emptyString)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .frame(width: Constants.imageWidthStaffCard, height: Constants.imageHeightStaffCard)
        .padding()
        .background(
            Color.gray
                .opacity(Constants.opacity02)
        )
        .cornerRadius(Constants.cornerRadius15)
    }
}

#Preview {
    StaffCard(staff: Staff.default)
}
