//
//  MainViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recordings: [RecordingModel] = []
    
    init() {
        loadRecordings()
    }
    
    func loadRecordings() {
        DispatchQueue.main.async {
            self.recordings = [
                RecordingModel(id: UUID(), title: "Добро пожаловать в SpeakerApp", image: "time-line", duration: "1:32", timestamp: Date())
            ]
        }
    }
    
    func addRecording(title: String, duration: String) {
        let newRecording = RecordingModel(id: UUID(), title: title, image: "time-line", duration: duration, timestamp: Date())
        DispatchQueue.main.async {
            self.recordings.insert(newRecording, at: 0)
        }
    }
    
    func filteredRecordings() -> [RecordingModel] {
        let lowercasedSearch = searchText.lowercased()
        return searchText.isEmpty ? recordings : recordings.filter { $0.title.lowercased().contains(lowercasedSearch) }
    }
}
