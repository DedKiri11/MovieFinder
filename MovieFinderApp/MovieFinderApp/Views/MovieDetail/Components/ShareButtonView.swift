//
//  ShareButtonView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 06.08.2024.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    var items: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ShareButtonView: View {
    var movie: Movie
    var model: ShareButtonViewModel {
        ShareButtonViewModel(movie: movie)
    }
    @State private var showingShareSheet = false
    var body: some View {
        ZStack {
            Button(action: {
                showingShareSheet = true
            }, label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .frame(width: Constants.boxWidthShareButton, alignment: .leading)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(Constants.cornerRadius15)
                }
            })
            .sheet(isPresented: $showingShareSheet) {
                ActivityView(items:[model.share()])
            }
        }
        .zIndex(2)
        .position(x: Constants.positionXShareButton, y: Constants.positionYShareButton)
    }
}

#Preview {
    ShareButtonView(movie: Movie.default)
}
