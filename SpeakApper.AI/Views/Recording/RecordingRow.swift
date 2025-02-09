//
//  RecordingRow.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import Foundation
import SwiftUI

//A view representing a single recording row with playback and delete options
struct RecordingRow: View {
    let recording: Recording
    let isPlaying: Bool
    let onPlay: () -> Void
    let onDelete: () -> Void
    
    @State private var showAlert = false
    var body: some View {
        HStack {
            //Recording Infor
            VStack(alignment: .leading, spacing: 5) {
                Text("No. \(recording.sequence)")
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(recording.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            Spacer()
            
            Button {
                onPlay()
            } label: {
                Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 10)
            
            //Delete Button with Haptic Feedback and Confirmation
            Button {
                //Trigger Haptic Feedback
                let  impactSoft = UIImpactFeedbackGenerator(style: .soft)
                impactSoft.impactOccurred()
                //Show confirmation alert
                showAlert = true
            } label: {
                Image(systemName: "trash.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Recording?"),
                    message: Text("Are you sure you want to delete this recording?"),
                    primaryButton: .destructive(Text("Delete")) {
                        onDelete()
                    },
                    secondaryButton: .cancel()
                )
            }
            
        }
        .padding()
    }
}
