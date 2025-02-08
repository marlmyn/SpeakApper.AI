//
//  RecordingDetailView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct RecordingDetailView: View {
    let recording: RecordingModel
    
    var body: some View {
        VStack {
            Text(recording.title)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            Spacer()
            Text("Транскрибирование аудиозаписи...")
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
