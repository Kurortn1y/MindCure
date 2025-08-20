//
//  + Custom modifier.swift
//  MindCure
//
//  Created by kurortn1y on 20.08.2025.
//

import Foundation
import SwiftUI

struct RoundedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.grayAppFon)
            .cornerRadius(16)
    }
}

extension View {
    func roundedBackground() -> some View {
        self.modifier(RoundedBackground())
    }
}
