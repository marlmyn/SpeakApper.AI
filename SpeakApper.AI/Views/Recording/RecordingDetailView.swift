//
//  RecordingDetailView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI
import AVFoundation

struct RecordingDetailView: View {
    let recording: Recording
    @ObservedObject var transcriptionManager = TranscriptionManager()
    
    @State private var transcriptionText: String = ""
    @State private var isTranscribing: Bool = true
    @State private var audioTitle: String = ""
    @State private var audioDuration: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying: Bool = false
    @State private var currentTime: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(audioTitle.isEmpty ? "Аудиозапись" : audioTitle)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Плеер аудио с длительностью
            HStack {
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("ButtonColor"))
                }
                
                VStack(alignment: .leading) {
                    Text("Аудиозапись")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(audioDuration)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            if isTranscribing {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .multilineTextAlignment(.center)
                Text("Транскрибирование аудиозаписи...")
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)
                Spacer()
            } else {
                ScrollView {
                    Text(transcriptionText)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    // Действие для кнопки AI
                }) {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("AI")
                    }
                    .padding()
                    .background(Color("ButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    // Действие для кнопки копирования
                }) {
                    Image(systemName: "doc.on.doc")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    // Действие для кнопки шаринга
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color("BackgroundColor").ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startTranscription()
            fetchAudioDuration()
            setupAudioPlayer()
        }
        .onDisappear {
            stopAudio()
        }
    }
    
    private func startTranscription() {
        transcriptionManager.transcribeAudio(url: recording.url) { transcription in
            DispatchQueue.main.async {
                if let text = transcription, !text.isEmpty {
                    transcriptionText = text
                    audioTitle = text.components(separatedBy: " ").prefix(4).joined(separator: " ")
                } else {
                    transcriptionText = "Не удалось транскрибировать запись."
                    audioTitle = "Аудиозапись"
                }
                isTranscribing = false
            }
        }
    }
    
    private func fetchAudioDuration() {
        let asset = AVURLAsset(url: recording.url)
        
        Task {
            do {
                let duration = try await asset.load(.duration)
                let durationInSeconds = CMTimeGetSeconds(duration)
                
                let minutes = Int(durationInSeconds) / 60
                let seconds = Int(durationInSeconds) % 60
                
                DispatchQueue.main.async {
                    self.audioDuration = String(format: "%02d:%02d", minutes, seconds)
                }
            } catch {
                print("Ошибка загрузки длительности: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func setupAudioPlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recording.url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Ошибка при загрузке аудио: \(error.localizedDescription)")
        }
    }
    
    private func togglePlayPause() {
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
    }
    
    private func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
