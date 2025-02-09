//
//  MainViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var recordings: [Recording] = []
    
    let audioRecorder = AudioRecorder()
    
    init() {
        fetchRecordings()
    }
    
    // Загрузка всех записей
    func fetchRecordings() {
        audioRecorder.fetchRecordings()
        recordings = audioRecorder.recordings
    }
    
    // Фильтрация записей по тексту поиска
    func filteredRecordings() -> [Recording] {
        if searchText.isEmpty {
            return recordings
        } else {
            return recordings.filter { $0.url.lastPathComponent.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // Воспроизведение записи
    func playRecording(_ recording: Recording) {
        if audioRecorder.audioPlayer?.isPlaying == true {
            audioRecorder.stopPlayback()
        }

        audioRecorder.playRecording(url: recording.url) { success in
            if success {
                print("Воспроизведение начато: \(recording.url.lastPathComponent)")
            }
        }
    }

    
    // Остановка воспроизведения
    func stopPlayback() {
        audioRecorder.stopPlayback()
    }
    
    // Удаление записи
    func deleteRecording(_ recording: Recording) {
        audioRecorder.deleteRecording(url: recording.url)
        fetchRecordings() // Обновляем список после удаления
    }
}
