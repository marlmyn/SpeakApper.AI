//
//  RecordingViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI
import AVFoundation

class RecordingViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var isPaused = false
    @Published var currentTime: String = "0:00"
    
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    private var elapsedTime: Int = 0
    
    
    func startRecording() {
        isRecording = true
        isPaused = false
        elapsedTime = 0
        updateTimer()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let tempDir = FileManager.default.temporaryDirectory
            let audioFilename = tempDir.appendingPathComponent("recording.m4a")
            
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatMPEG4AAC,
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            
            startTimer()
        } catch {
            print("Ошибка записи: \(error.localizedDescription)")
        }
    }
    
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        stopTimer()
    }
    
    
    func pauseOrResumeRecording() {
        guard let recorder = audioRecorder else { return }
        
        if isPaused {
            recorder.record()
        } else {
            recorder.pause()
        }
        isPaused.toggle()
    }
    
    
    func cancelRecording() {
        audioRecorder?.stop()
        isRecording = false
        stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1
            let minutes = self.elapsedTime / 60
            let seconds = self.elapsedTime % 60
            self.currentTime = String(format: "%d:%02d", minutes, seconds)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer() {
        self.currentTime = "0:00"
    }
}
