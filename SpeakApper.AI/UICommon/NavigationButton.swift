//
//  NavigationButton.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import Foundation
import SwiftUI

struct NavigationButton: View {
    let title: String
    let icon: String

    var body: some View {
        VStack {
            Image(icon)
                .font(.system(size: 24))
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }
}

