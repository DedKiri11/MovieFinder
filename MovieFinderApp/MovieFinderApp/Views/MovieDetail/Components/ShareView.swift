//
//  ShareView.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 08.08.2024.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    var items: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    
}

