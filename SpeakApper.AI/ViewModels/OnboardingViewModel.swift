//
//  OnboardingViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 29.01.2025.
//
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var selectedCategory: String? 

    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    let steps: [AnyView]

    init() {
        steps = [
            AnyView(WelcomeScreen()),
            AnyView(OnboardingCardView(onboarding: onboardingData[0])),
            AnyView(OnboardingCardView(onboarding: onboardingData[1])),
            AnyView(OnboardingSelectionPage(
                title: "Какая из категорий лучше всего описывает вас?",
                subtitle: "Ваш отзыв поможет сделать наше приложение лучше!",
                options: [
                    OptionModel(title: "Преподаватель или Коуч", icon: "Vector1"),
                    OptionModel(title: "IT-специалист", icon: "Vector2"),
                    OptionModel(title: "Автор контента", icon: "Vector3"),
                    OptionModel(title: "Руководитель и предприниматель", icon: "Vector4"),
                    OptionModel(title: "Медработник", icon: "Vector5"),
                    OptionModel(title: "Студент или учащийся", icon: "Vector6"),
                    OptionModel(title: "Юрист, финансист, консультант", icon: "Vector7"),
                    OptionModel(title: "Другое", icon: "Vector8")
                ]
            )),
        ]
    }

    func nextPage() {
        if currentPage < steps.count - 1 {
            currentPage += 1
        } else {
            hasSeenOnboarding = true
        }
    }
}
