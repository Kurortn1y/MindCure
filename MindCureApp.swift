//
//  MindCureApp.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

@main
struct MindCureApp: App {
    
    @State private var coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .environment(coordinator)
    }
}
