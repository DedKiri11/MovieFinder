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
            if let poster = staff.posterUrl {
                AsyncImage(url: URL(string: poster)) { image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
                }
            } else {
                Image(.unknown)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius15))
            }
                
            Text(staff.nameRu ?? Constants.emptyString)
            Text(staff.description ?? Constants.emptyString)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .frame(width: 200, height: 200)
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
