//
//  Coordinator.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import Foundation
import Observation
import SwiftUI

enum Page: Hashable  {
    case main
    case threapyScreen
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
    
    
    //MARK: - Navigation Methods
    func push(page: Page) {
        path.append(page)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    
    
    //MARK: - Build Methods
    
    @ViewBuilder
    func build(_ page: Page) -> some View {
        switch page {
        case .main:
            MainView()
        case .threapyScreen:
            TherapyView()
        }
    }
    
    
    
    
    
    //MARK: -
}
