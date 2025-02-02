//
//  RecordButton.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import Foundation
import SwiftUI

struct RecordButton: View {
    var body: some View {
        Button(action: {
            print("Начать запись")
        }) {
            ZStack {
                Image("Bttn")
                    .resizable()
                    .frame(width: 144, height: 144)
            }
            .padding()
        }
    }
}

