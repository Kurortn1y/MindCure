//
//  MainView.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

struct MainView: View {
    
    @Environment(Coordinator.self) var coordinator
    
    var body: some View {
        Text("Hello, Main View!")
        Button("go therapy") {
            coordinator.push(page: .threapyScreen)
        }
    }
}

#Preview {
    MainView()
        .environment(Coordinator())
}
