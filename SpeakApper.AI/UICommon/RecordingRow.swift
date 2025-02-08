//
//  RecordingRow.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI

struct RecordingRow: View {
    let recording: RecordingModel
    
    var body: some View {
        NavigationLink(destination: RecordingDetailView(recording: recording)) {
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(recording.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 8) {
                            Text(timeAgo(from: recording.timestamp))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.gray)
                            
                            Text(recording.duration)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
                Divider()
                    .background(Color.gray.opacity(0.5))
            }
            .padding(.vertical, 8)
        }
        .background(Color("BackgroundColor"))
    }
    
    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
