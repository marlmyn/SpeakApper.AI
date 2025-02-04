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
        VStack(spacing: 4) {
            HStack {
                VStack(alignment: .leading) {
                    Text(recording.title)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Text("Только что")
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
            .padding()
            
            Divider()
                .background(Color.gray)
        }
        .background(Color("BackgroundColor"))
    }
}




