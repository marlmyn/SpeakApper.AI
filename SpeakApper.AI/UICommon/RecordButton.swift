//
//  RecordButton.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUICore
import SwiftUI

struct RecordButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(color)
                Text(title)
                    .foregroundColor(.white)
                    .font(.footnote)
            }
        }
    }
}
