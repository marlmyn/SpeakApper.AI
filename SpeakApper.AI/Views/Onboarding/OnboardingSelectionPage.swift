//
//  OnboardingSelectionPage.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import SwiftUI

struct OnboardingSelectionPage: View {
    let title: String
    let subtitle: String
    let options: [OptionModel]
    
    @State private var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    // Логика пропуска онбординга
                }) {
                    Text("Пропустить")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            .padding(.trailing)

            
            Text(title)
                .multilineTextAlignment(.center)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding()
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
         
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(options, id: \.title) { option in
                    Button(action: {
                        selectedOption = option.title
                    }) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("DarkGray").opacity(0.8))
                                .frame(height: 80)
                                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                            
                            HStack {
                                Image(option.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)

                                Text(option.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)

                                Spacer()
                            }
                            .padding(.leading, 12)
                            
                            
                            if selectedOption == option.title {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.purple)
                                    }
                                    Spacer()
                                }
                                .padding(8)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedOption == option.title ? Color.blue : Color.clear, lineWidth: 2)
                        )
                    }
                }
            }
            .padding()

            Spacer()
        }
        .background(Color("BackgroundColor").ignoresSafeArea()) 
    }
}
