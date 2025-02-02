//
//  BannerView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import Foundation
import SwiftUI

struct BannerView: View {
    var body: some View {
        HStack {
            Image("diamond")
                .resizable()
                .frame(width: 31, height: 32)
            Text("Попробуйте SpeakApper Premium бесплатно Нажмите, чтобы попробовать сейчас!")
                .font(.system(size: 15))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#6D4BCC"), Color(hex: "#515EDB"), Color(hex: "#2F3892")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .padding(.horizontal, 8)
    }
}

#Preview {
    BannerView()
}
