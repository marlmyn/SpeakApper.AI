//
//  RecordingView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: MainViewModel
    @Binding var hasSavedRecording: Bool

    @State private var recordingTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var isPaused = false

    let maxRecordingDuration: TimeInterval = 120 // 2 минуты

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 24) {

                
                AudioWaveFormView(audioLevels: viewModel.audioRecorder.audioLevels)
                    .frame(height: 150)
                    .padding(.top, 60)

                Spacer()
                
                Text("\(formatTime(recordingTime)) / 2:00")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)

                BannerView()
                    .padding(.horizontal)

               

                // Кнопки управления записью
                HStack(spacing: 40) {

                    Button(action: {
                        stopRecording(delete: true)
                        isPresented = false
                    }) {
                        VStack {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 42, height: 42)
                                .foregroundColor(Color("xmarkColor"))
                            Text("Отклонить")
                                .foregroundColor(.subtitle)
                                .font(.caption)
                        }
                    }

                    // ⏹ Сохранить запись
                    Button(action: {
                        stopRecording(delete: false)
                        hasSavedRecording = true
                        isPresented = false
                    }) {
                        VStack {
                            Image(systemName: "stop.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color("micColor"))
                            Text("Сохранить")
                                .foregroundColor(.subtitle)
                                .font(.caption)
                        }
                    }

                    // Пауза/Возобновить
                    Button(action: {
                        togglePause()
                    }) {
                        VStack {
                            Image(systemName: isPaused ? "mic.circle.fill" : "pause.circle.fill")
                                .resizable()
                                .frame(width: 42, height: 42)
                                .foregroundColor(Color("xmarkColor"))
                            Text(isPaused ? "Возобновить" : "Пауза")
                                .foregroundColor(.subtitle)
                                .font(.caption)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .onAppear {
                startRecording()
            }
            .onDisappear {
                stopRecording(delete: false)
            }
        }
    }

    // MARK: - Управление записью

    private func startRecording() {
        viewModel.audioRecorder.startRecording()
        startTimer()
    }

    private func stopRecording(delete: Bool) {
        viewModel.audioRecorder.stopRecording()
        timer?.invalidate()

        if delete {
            if let lastRecording = viewModel.audioRecorder.recordings.last {
                viewModel.audioRecorder.deleteRecording(url: lastRecording.url)
            }
        } else {
            viewModel.fetchRecordings()
        }
    }

    private func togglePause() {
        isPaused.toggle()
        if isPaused {
            viewModel.audioRecorder.audioRecorder?.pause()
            timer?.invalidate()
        } else {
            viewModel.audioRecorder.audioRecorder?.record()
            startTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if recordingTime < maxRecordingDuration {
                recordingTime += 1
            } else {
                stopRecording(delete: false)
                isPresented = false
            }
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

#Preview {
    RecordingView(isPresented: .constant(true), viewModel: MainViewModel(), hasSavedRecording: .constant(false))
}
