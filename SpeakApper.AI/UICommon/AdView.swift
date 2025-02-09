//
//  AdView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 09.02.2025.
//

import Foundation
import SwiftUI

struct AdView: View {
    var body: some View {
        HStack {
            Image("diamond")
                .resizable()
                .frame(width: 31, height: 32)
                .padding(.leading, 8)
            Text("Записывайте до 100 минут с помощью SpeakApper Premium")
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .padding(.leading, 4)
            Spacer()
        }
        .frame(width: 361, height: 72)
        
        
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#6D4BCC"), Color(hex: "#515EDB"), Color(hex: "#2F3892")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
    }
}

#Preview {
    BannerView()
}
