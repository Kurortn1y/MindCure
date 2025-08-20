//
//  CoordinatorPage.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

#Preview {
    CoordinatorView()
        .environment(Coordinator())
}

struct CoordinatorView: View {
    
    @Environment(Coordinator.self) var coordinator
    
    var body: some View {
        
        @Bindable var coordinator = coordinator
        
        NavigationStack(path: $coordinator.path) {
            TabView {
                coordinator.build(.main)
                    .tabItem { Text("1") }
                
                SettingsView()
                    .tabItem { Text("2") }
            }
            .navigationDestination(for: Page.self) { page in
                coordinator.build(page)
            }
            .fullScreenCover(item: $coordinator.cover) { cover in
                coordinator.buildC(cover)
            }
        }
    }
}
