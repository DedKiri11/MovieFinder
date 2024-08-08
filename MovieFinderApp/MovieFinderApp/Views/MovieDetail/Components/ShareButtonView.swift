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
    @Binding var isActive: Bool
    var model: ShareButtonViewModel {
        ShareButtonViewModel(movie: movie)
    }
    @State private var showingShareSheet = false
    var body: some View {
        NavigationStack {
            ZStack {
            
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .navigationDestination(isPresented: $isActive) {
                            ActivityView(items: [model.share()])
                            }
            }
           
        }
    }
}

#Preview {
    ShareButtonView(movie: Movie.default, isActive: .constant(false))
}
