//
//  ImportRecordView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct ImportRecordView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundStyle(.orange)
            Text("Импорт записи")
                .font(.system(size: 24, weight: .bold))
        }
        .padding()
    }
}

#Preview {
    ImportRecordView()
}
