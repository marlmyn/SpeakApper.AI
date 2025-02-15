//
//  RecordingViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import Foundation
import Combine

class RecordingViewModel: ObservableObject {
    @Published var recordings: [Recording] = []
    @Published var searchText: String = ""
    @Published var transcriptions: [URL: String] = [:]

    let audioRecorder = AudioRecorder()
    private let transcriptionManager = TranscriptionManager()

    init() {
        fetchRecordings()
    }

    // MARK: - Получение записей
    func fetchRecordings() {
        audioRecorder.fetchRecordings()
        recordings = audioRecorder.recordings
        fetchTranscriptions()
    }

    // MARK: - Транскрипция
    private func fetchTranscriptions() {
        for recording in recordings {
            transcriptionManager.transcribeAudio(url: recording.url) { [weak self] transcription in
                DispatchQueue.main.async {
                    if let transcription = transcription {
                        self?.transcriptions[recording.url] = transcription
                    }
                }
            }
        }
    }

    // MARK: - Воспроизведение записи
    func playRecording(_ recording: Recording) {
        audioRecorder.playRecording(url: recording.url) { success in
            if success {
                print("Воспроизведение начато")
            } else {
                print("Ошибка воспроизведения")
            }
        }
    }

    // MARK: - Удаление записи
    func deleteRecording(_ recording: Recording) {
        audioRecorder.deleteRecording(url: recording.url)
        fetchRecordings()
    }

    // MARK: - Фильтрация записей
    func filteredRecordings() -> [Recording] {
        if searchText.isEmpty {
            return recordings
        } else {
            return recordings.filter {
                $0.formattedDate.localizedCaseInsensitiveContains(searchText) ||
                $0.url.lastPathComponent.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
