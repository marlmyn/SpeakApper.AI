//
//  BulletListView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 29.01.2025.
//

import Foundation
import SwiftUI

struct BulletListView: View {
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top) {
                    Text("•")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(item)
                }
            }
        }
    }
}
