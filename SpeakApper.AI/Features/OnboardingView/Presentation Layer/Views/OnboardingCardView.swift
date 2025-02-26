//
//  OnboardingCardView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//


import Foundation
import SwiftUI

struct OnboardingCardView: View {
    // MARK: - PROPERTIES
    
    var onboarding: OnboardingModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Image(onboarding.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                Text(onboarding.title)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                BulletListView(items: onboarding.description)
                    .font(.body)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}




