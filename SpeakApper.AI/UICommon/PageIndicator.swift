//
//  PageIndicator.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import Foundation
import SwiftUI

struct PageIndicator: View {
    var currentPage: Int
    var totalPages: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .frame(width: index == currentPage ? 10 : 8, height: index == currentPage ? 10 : 8)
                    .foregroundColor(index == currentPage ? .circle : .gray.opacity(0.5))
            }
        }
        .padding(.bottom, 20)
    }
}
