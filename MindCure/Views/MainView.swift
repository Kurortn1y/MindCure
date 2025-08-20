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
        ZStack {
            Color.stockFon
                .ignoresSafeArea()
            VStack {
                Button("go session") {
                    coordinator.open(.sessionCover)
                }
                .padding(50)
                Button("go Ball") {
                    coordinator.open(.ballCover)
                }
            }
        }
    }
}


#Preview {
    MainView()
        .environment(Coordinator())
}
