//
//  DynamicNavigationItemsView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 15.02.2025.
//

import Foundation
import SwiftUI

struct DynamicNavigationItemsView: View {
    var body: some View {
        HStack(spacing: 36) {
            NavigationLink(destination: ImportRecordView()) {
                VStack {
                    Image("import")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Импорт записи")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
            }
            NavigationLink(destination: YoutubeView()) {
                VStack {
                    Image("youtube")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Youtube")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
            }
            NavigationLink(destination: AIIdeaView()) {
                VStack {
                    Image("ai-idea")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Запрос функции")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
            }
            NavigationLink(destination: FAQView()) {
                VStack {
                    Image("faq")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("FAQ")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
}


