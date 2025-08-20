//
//  SessionView.swift
//  MindCure
//
//  Created by kurortn1y on 19.08.2025.
//

import SwiftUI

struct SessionView: View {
    
    @Environment(Coordinator.self) var coordinator
    @Environment(\.dismiss) var dismiss
    
    @State private var vm = ViewModel()
    
    var body: some View {
        
        @Bindable var vm = vm
        
        ZStack {
            Color.stockFon
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // MARK: Кнопка закрытия ( прерывания сессии)
                if vm.therapyState != .ball {
                    HStack() {
                        Button("✕") { dismiss() }
                            .font(.title2)
                        Spacer()
                    }
                }
                
                // MARK: Основной контент
                MainSection(vm: vm)
            }
            .padding()
        }
    }
}

// MARK: - Main Section

struct MainSection: View {
    
    @Bindable var vm: ViewModel
    
    var body: some View {
        switch vm.therapyState {
        case .isStarting:
            StartingQuestionsView(vm: vm)
        case .ball:
            BouncingBallView(vm: vm)
        case .isProcessing:
            ProcessingView(vm: vm)
        case .isClosing:
            ClosingView(vm: vm)
        }
    }
}

// MARK: - Starting Questions
struct StartingQuestionsView: View {
    
    @Bindable var vm: ViewModel
    
    var body: some View {
        switch vm.stepIndex {
        case .first:
            StepView(
                title: "Какое событие или картинка приходят в голову?",
                content: {
                    TextField("Опишите", text: $vm.session.eventImageOrMemory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                },
                nextAction: { vm.stepIndex = .second }
            )
            .roundedBackground()
            
        case .second:
            MultiSelectStepView(
                title: "Что чувствуешь в теле?",
                options: vm.bodyOptions,
                selectedOptions: $vm.session.bodySensation,
                nextAction: { vm.stepIndex = .third }
            )
            .roundedBackground()

            
        case .third:
            SingleSelectStepView(
                title: "Какое твое первичное чувство?",
                options: vm.emotionOptions,
                selectedOption: $vm.session.primaryEmotion,
                nextAction: { vm.stepIndex = .fourth }
            )
            .roundedBackground()
        case .fourth:
            StepView(
                title: "Какая негативная мысль о себе?",
                content: {
                    TextField("Напишите", text: $vm.session.negativeThought)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                },
                nextAction: { vm.stepIndex = .fifth }
            )
            .roundedBackground()
        case .fifth:
            IntensityStepView(
                title: "Насколько это неприятно? 0–10",
                value: $vm.session.intensity,
                range: 0...10,
                buttonTitle: "Начать переработку",
                nextAction: { vm.therapyState = .ball }
            )
            .roundedBackground()
        }
    }
}

// MARK: - Processing View
struct ProcessingView: View {
    @Bindable var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            IntensitySlider(
                title: "Насколько неприятно сейчас? (0–10)",
                value: $vm.session.intensity,
                range: 0...10
            )
            
            TextField("Что нового появилось? (картинка, мысль, чувство)",
                     text: $vm.session.newThoughtOrImage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Что происходит в теле?",
                     text: $vm.session.bodyChange)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack(spacing: 20) {
                Button("Ещё сет") { vm.therapyState = .ball }
                Button("Перейти к завершению") { vm.therapyState = .isClosing }
            }
        }
        .frame(width: 320, height: 630)
        .roundedBackground()
        
    }
}

// MARK: - Closing View
struct ClosingView: View {
    @Bindable var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            IntensitySlider(
                title: "Когда думаешь о событии, насколько неприятно сейчас? (0–10)",
                value: $vm.session.finalIntensity,
                range: 0...10
            )
            
            TextField("Где в теле ощущаешь это сейчас?",
                     text: $vm.session.finalBodySensation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Какая позитивная мысль о себе приходит?",
                     text: $vm.session.positiveThought)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            IntensitySlider(
                title: "Насколько она ощущается верной? (0–7)",
                value: $vm.session.positiveBeliefStrength,
                range: 0...7
            )
            
            Button("Завершить сессию") {
                print("Сессия завершена: \(vm.session)")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(height: 630)
        .roundedBackground()
    }
}

// MARK: - Bouncing Ball View
struct BouncingBallView: View {
    let vm: ViewModel
    
    var body: some View {
        ZStack {
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate
                GeometryReader { geometry in
                    let amplitude = geometry.size.width / 2 - 50
                    let x = geometry.size.width / 2 + amplitude * sin(time)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .position(x: x, y: geometry.size.height / 2)
                }
            }
            
            VStack {
                Spacer()
                Button("Закрыть") {
                    vm.therapyState = .isProcessing
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Reusable Components
struct StepView<Content: View>: View {
    
    let title: String
    @ViewBuilder let content: Content
    let nextAction: () -> Void
    
    var body: some View {
            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                content
                    .padding()
                
                Button("Далее", action: nextAction)
                    .buttonStyle(.borderedProminent)
            }
            .frame(width: 320, height: 630)
    }
}

struct MultiSelectStepView: View {
    let title: String
    let options: [String]
    @Binding var selectedOptions: [String]
    let nextAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            LazyVStack(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    OptionButton(
                        text: option,
                        isSelected: selectedOptions.contains(option)
                    ) {
                        toggleOption(option)
                    }
                }
            }
            
            Button("Далее", action: nextAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(width: 320, height: 630)
    }
    
    private func toggleOption(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.removeAll { $0 == option }
        } else {
            selectedOptions.append(option)
        }
    }
}

struct SingleSelectStepView: View {
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    let nextAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            LazyVStack(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    OptionButton(
                        text: option,
                        isSelected: selectedOption == option
                    ) {
                        selectedOption = option
                    }
                }
            }
            
            Button("Далее", action: nextAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(width: 320, height: 630)
    }
}

struct IntensityStepView: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    let buttonTitle: String
    let nextAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            IntensitySlider(title: title, value: $value, range: range)
            
            Button(buttonTitle, action: nextAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(width: 320, height: 630)
    }
}

struct IntensitySlider: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0) }
                ),
                in: Double(range.lowerBound)...Double(range.upperBound),
                step: 1
            )
            
            Text("Значение: \(value)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct OptionButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SessionView()
        .environment(Coordinator())
}
