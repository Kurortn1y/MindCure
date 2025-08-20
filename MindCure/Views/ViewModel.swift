//
//  ViewModel.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import Foundation
import Observation

@Observable
final class ViewModel {
    
    init(file: String = #file, function: String = #function, line: Int = #line) {
        print("VM inited at file: \(file), function: \(function), line: \(line)")
    }
    
    deinit{
        print("VM DEinited")
    }
    
    var session = EMDRSession()
    var therapyState: TherapyState = .isStarting
    var stepIndex: StepIndex = .first
    
    let bodyOptions = ["Напряжение", "Тяжесть", "Тепло", "Холод", "Тремор", "Дыхание", "Пульсация", "Онемение"]
    let emotionOptions = ["Страх", "Грусть", "Злость", "Стыд", "Одиночество", "Беспомощность", "Вина", "Тревога", "Отвращение"]
    
    enum StepIndex {
        case first
        case second
        case third
        case fourth
        case fifth
    }

    enum TherapyState {
        case isStarting
        case ball
        case isProcessing
        case isClosing
    }

}

