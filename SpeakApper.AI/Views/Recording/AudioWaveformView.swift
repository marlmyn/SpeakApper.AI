//
//  AudioWaveformView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 08.02.2025.
//

import SwiftUI

struct AudioWaveFormView: View {
    let audioLevels: [CGFloat]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 3) {
                ForEach(audioLevels.indices, id: \.self) { index in
                    let level = min(max(audioLevels[index], 0.1), 1.0) // Нормализация значений (0.1 - 1.0)
                    
                    Capsule()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                        .frame(
                            width: (geometry.size.width / CGFloat(audioLevels.count)) - 3, // Автоматический расчёт ширины
                            height: max(level * 120, 10) // Высота в зависимости от уровня звука
                        )
                        .animation(.easeInOut(duration: 0.1), value: level)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding(.horizontal, 10)
    }
}
