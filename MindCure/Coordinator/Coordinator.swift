//
//  Coordinator.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import Foundation
import Observation
import SwiftUI


enum FullScreencover: String, Identifiable {
    
    case ballCover
    case sessionCover
    
    var id: String {
        self.rawValue
    }
}

enum Page: Hashable  {
    case main
}


@Observable
final class Coordinator {
    
    init() {
        print("coord initeed")
    }
    deinit {
        print("coord DEiniteed")
    }
    
    var path = NavigationPath()
    var cover: FullScreencover?
    
    
    //MARK: - Navigation Methods
    func push(page: Page) {
        path.append(page)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func open(_ cover: FullScreencover) {
        self.cover = cover
    }
    
    
    //MARK: - Build Methods
    
    @ViewBuilder
    func build(_ page: Page) -> some View {
        switch page {
        case .main:
            MainView()
        }
    }
    
    @ViewBuilder
    func buildC(_ cover: FullScreencover) -> some View {
        switch cover {
        case .sessionCover:
            SessionView()
        case .ballCover:
            TherapyView()
        }
    }
    
}
