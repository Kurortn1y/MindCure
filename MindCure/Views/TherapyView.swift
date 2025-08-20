//
//  TherapyPage.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

struct TherapyView: View {
    
    @State private var moveRight = false
    @Environment(Coordinator.self) var coordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        @Bindable var coordinator = coordinator
        
        GeometryReader { geometry in
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .position(
                    x: moveRight ? geometry.size.width -  95 : 25,
                    y: geometry.size.height / 2 // всегда по центру по вертикали
                )
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever(autoreverses: true),
                    value: moveRight
                )
                .onAppear {
                    moveRight = true
                }
        }
        Button("asd") {
            dismiss()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TherapyView()
        .environment(Coordinator())
}
