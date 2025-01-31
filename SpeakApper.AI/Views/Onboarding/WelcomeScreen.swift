//
//  WelcomeScreen.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import SwiftUI

struct WelcomeScreen: View {
    
    var body: some View {
        VStack {
            Image("ellipse")
                .resizable()
                .frame(width: 140, height: 140)
                .padding()
            
            Text("SpeakApper")
                .font(.system(size: 41, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            Text("Загружайте или записывайте аудио на любом языке для мгновенного преобразования.")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Добавьте это
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

#Preview {
    WelcomeScreen()
}
