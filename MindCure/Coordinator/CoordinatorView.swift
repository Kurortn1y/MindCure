//
//  CoordinatorPage.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

struct CoordinatorView: View {
    
    @Environment(Coordinator.self) var coordinator
    
    
    var body: some View {
        
        @Bindable var coordinator = coordinator
        
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.main)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page)
                }
        }
    }
}

#Preview {
    CoordinatorView()
        .environment(Coordinator())
}
