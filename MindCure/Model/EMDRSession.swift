//
//  EMDRSession.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import Foundation
//
//struct EMDRSession {
//    var eventImageOrMemory: String = ""      // Событие / картинка
//    var bodySensation: [String] = []         // Ощущения в теле (множественный выбор)
//    var primaryEmotion: String = ""          // Первичное чувство (одно слово)
//    var negativeThought: String = ""         // Негативная мысль
//    var intensity: Int = 0                   // Насколько неприятно 0–10
//}
struct EMDRSession: Identifiable, Codable {
    var id = UUID()
    
    // 1. Вводные ответы
    var eventImageOrMemory: String = ""
    var bodySensation: [String] = []
    var primaryEmotion: String = ""
    var negativeThought: String = ""
    var intensity: Int = 0
    
    // 2. Переработка (цикл)
    var cycles: Int = 0
    var newThoughtOrImage: String = ""
    var bodyChange: String = ""
    
    // 3. Завершение
    var finalIntensity: Int = 0
    var finalBodySensation: String = ""
    var positiveThought: String = ""
    var positiveBeliefStrength: Int = 0
}
