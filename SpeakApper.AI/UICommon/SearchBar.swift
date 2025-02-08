//
//  SearchBar.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image("mangnifyingglass")
            
            TextField("Поиск", text: $text)
                .foregroundColor(.white)
                .placeholder(when: text.isEmpty) {
                    Text("Поиск").foregroundColor(.white)
                        .frame(height: 54)
                }
                .padding(10)
            
        }
        .padding(.horizontal, 10)
        .frame(height: 54)
        .background(Color("searchColor"))
        .cornerRadius(10)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
