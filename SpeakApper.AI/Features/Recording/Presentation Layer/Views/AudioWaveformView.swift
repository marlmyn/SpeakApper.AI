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
                    let level = min(max(audioLevels[index], 0.1), 1.0) 
                    
                    Capsule()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                        .frame(
                            width: (geometry.size.width / CGFloat(audioLevels.count)) - 3,
                            height: max(level * 120, 10)
                        )
                        .animation(.easeInOut(duration: 0.1), value: level)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding(.horizontal, 10)
    }
}
