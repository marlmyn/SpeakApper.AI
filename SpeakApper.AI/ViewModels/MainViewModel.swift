//
//  MainViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recordings: [RecordingModel] = []
    
    init() {
        loadRecordings()
    }
    
    func loadRecordings() {
        // Networking
        recordings = [
            RecordingModel(id: UUID(), title: "Добро пожаловать в SpeakerApp", image: "time-line", duration: "1:32", timestamp: Date())
        ]
    }
    
    func filteredRecordings() -> [RecordingModel] {
        if searchText.isEmpty {
            return recordings
        } else {
            return recordings.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
