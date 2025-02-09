//
//  PaywallView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import SwiftUI

struct PaywallView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State private var currentIndex = 0
    @Binding var isOnboardingFinished: Bool
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isOnboardingFinished = true
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                }
                Spacer()
            }
            
            Text("Выберите план")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 36)
            
            GeometryReader { geometry in
                VStack {
                    if let features = paywallSlides[currentIndex].features {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(features) { feature in
                                HStack {
                                    if let icon = feature.icon {
                                        Image(systemName: icon)
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                    }
                                    Text(feature.text)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.3, alignment: .top)
                        
                    } else if let review = paywallSlides[currentIndex].review {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("**\(review.username)**")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                            
                            HStack(spacing: 4) {
                                ForEach(0..<review.rating, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            
                            Text(review.reviewText)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .lineLimit(4)
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.3, alignment: .top)
                    }
                    Spacer()
                    HStack {
                        ForEach(0..<paywallSlides.count, id: \.self) { index in
                            Circle()
                                .frame(width: index == currentIndex ? 10 : 8, height: index == currentIndex ? 10 : 8)
                                .foregroundColor(index == currentIndex ? Color("ButtonColor") : .gray.opacity(0.5))
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
            .frame(maxHeight: 200)
            
            Spacer()
            SubscriptionOptionsView()
            Spacer()
            
            // Кнопка "Продолжить без подписки"
            Button(action: {
                isOnboardingFinished = true
            }) {
                Text("Продолжить")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("ButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
            }
            
            // Условия
            HStack {
                Text("Условия использования")
                Spacer()
                Text("Политика конфиденциальности")
                Spacer()
                Text("Восстановить покупки")
            }
            .foregroundColor(.gray)
            .font(.system(size: 14))
            .padding(.top, 8)
            .padding(.horizontal, 12)
            .padding(.bottom, 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % paywallSlides.count
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
