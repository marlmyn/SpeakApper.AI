//
//  RecordingRow.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI

struct RecordingRow: View {
    let recording: Recording
    let isPlaying: Bool
    let onPlay: () -> Void
    let onDelete: () -> Void

    @State private var showAlert = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Запись №\(recording.sequence)")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(recording.formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                onPlay()
            }) {
                Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 10)

            Button(action: {
                let impactSoft = UIImpactFeedbackGenerator(style: .soft)
                impactSoft.impactOccurred()
                showAlert = true
            }) {
                Image(systemName: "trash.fill")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Удалить запись?"),
                    message: Text("Вы уверены, что хотите удалить эту запись?"),
                    primaryButton: .destructive(Text("Удалить")) {
                        onDelete()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(10)
    }
}
