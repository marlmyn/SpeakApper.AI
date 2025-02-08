//
//  RecordingButtonView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct RecordingButtonView: View {
    @Binding var isRecordingPresented: Bool
    @Binding var hasSavedRecording: Bool
    @State private var showTapIcon = true
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Button(action: {
                    isRecordingPresented = true
                    showTapIcon = false
                }) {
                    Image("Bttn")
                        .resizable()
                        .frame(width: 144, height: 144)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                
                if showTapIcon {
                    Image("hand.tap")
                        .resizable()
                        .frame(width: 35, height: 36)
                        .offset(y: 80)
                }
            }
            
            Spacer()
        }
    }
}
