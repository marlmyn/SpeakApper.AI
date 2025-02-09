//
//  Recording.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 09.02.2025.
//

import Foundation
import SwiftUI
import Combine

struct Recording: Identifiable, Equatable {
    let id: String 
    let url: URL
    let date: Date
    let sequence: Int
    
    init(url: URL, date: Date, sequence: Int) {
        self.id = url.path
        self.url = url
        self.date = date
        self.sequence = sequence
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var formattedDate: String {
        return Recording.dateFormatter.string(from: date)
    }
    
    static func == (lhs: Recording, rhs: Recording) -> Bool {
        return lhs.id == rhs.id
    }
}

