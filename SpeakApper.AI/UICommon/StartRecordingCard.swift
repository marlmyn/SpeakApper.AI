//
//  StartRecordingCard.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct StartRecordingCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Начните запись")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            
            Text("Просто нажмите кнопку и сделайте свою первую голосовую запись на...")
                .font(.system(size: 14))
                .foregroundColor(.white)
        }
        .padding(16)
        .frame(width: 299, height: 104, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("cardColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "#ABABAB").opacity(0.18), lineWidth: 1)
                )
        )
    }
}


#Preview {
    StartRecordingCard()
}
