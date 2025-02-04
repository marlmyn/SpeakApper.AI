//
//  OnboardingData.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import Foundation
import SwiftUI

// MARK: - Onboarding DATA

let onboardingData: [OnboardingModel] = [
    OnboardingModel(image: "iconoir_microphone-speaking-solid",
                    title: "Преобразование речи в текст",
                    description:
                        ["Загружайте или записывайте аудио на любом языке для мгновенного преобразования.",
                         "Достигайте точности до 99% благодаря передовым алгоритмам.",
                         "Преобразовывайте аудиофайлы длительностью до одного часа без потерь качества."]),
    OnboardingModel(image: "ri_voice-ai-fill",
                    title: "AI редактирование в одно касание",
                    headline: "Преобразуйте текст в помощью AI в одно касание:",
                    description:
                        ["Резюмирование, структурирование информации, оформление в виде списка.",
                         "Переработка текста: перефразирование, изменение стиля и тона.",
                         "Мгновенный перевод на множество языков."])
]
