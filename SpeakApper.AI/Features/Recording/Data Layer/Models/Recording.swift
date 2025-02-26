//
//  Recording.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 09.02.2025.
//

import Foundation

struct Recording: Identifiable, Equatable {
    let id = UUID()
    let url: URL
    let date: Date
    let sequence: Int
    var transcription: String?

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    static func == (lhs: Recording, rhs: Recording) -> Bool {
        return lhs.id == rhs.id
    }
}
