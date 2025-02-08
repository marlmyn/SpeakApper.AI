//
//  RecordingView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct RecordingView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: MainViewModel
    @State private var isRecording = false
    @Binding var hasSavedRecording: Bool
    @State private var recordedTime: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text(isRecording ? "Запись идет..." : "Начало записи")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text(timeFormatted(recordedTime))
                .font(.title)
                .foregroundColor(.gray)
            
            HStack(spacing: 30) {
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    toggleRecording()
                }) {
                    Image(systemName: isRecording ? "pause.circle.fill" : "stop.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    if recordedTime > 3 {
                        saveRecording()
                    } else {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(recordedTime > 3 ? .green : .gray)
                }
            }
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
        .onAppear {
            startRecording()
        }
    }
    
    func toggleRecording() {
        if isRecording {
            isRecording = false
            timer?.invalidate()
        } else {
            isRecording = true
            startTimer()
        }
    }
    
    func startRecording() {
        isRecording = true
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            recordedTime += 1
        }
    }
    
    func timeFormatted(_ totalSeconds: Double) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func saveRecording() {
        let title = "Новая запись"
        let duration = timeFormatted(recordedTime)
        viewModel.addRecording(title: title, duration: duration)
        hasSavedRecording = true
        isPresented = false
    }
}
