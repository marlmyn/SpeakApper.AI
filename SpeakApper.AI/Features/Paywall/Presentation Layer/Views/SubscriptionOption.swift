//
//  SubscriptionOption.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 01.02.2025.
//

import SwiftUI

struct SubscriptionOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let price: String
    let isBestValue: Bool
}

struct SubscriptionOptionsView: View {
    @State private var selectedOption: UUID?
    @State private var isTrialEnabled: Bool = false 
    
    let options: [SubscriptionOption] = [
        SubscriptionOption(title: "Годовой план", subtitle: "всего 2 082 kzt в месяц", price: "24 990 kzt в год", isBestValue: true),
        SubscriptionOption(title: "3 дня бесплатно", subtitle: "затем 6 990 kzt в месяц", price: "", isBestValue: false)
    ]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(options) { option in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(option.title)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))

                        HStack(spacing: 4) {
                            if !option.price.isEmpty {
                                Text(option.price)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                            if !option.subtitle.isEmpty {
                                Text(option.subtitle)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    Spacer()
                    
                    if option.isBestValue {
                        Text("Сэкономьте 70%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    }
                    Circle()
                        .strokeBorder(Color.white, lineWidth: selectedOption == option.id ? 3 : 1)
                        .background(selectedOption == option.id ? Circle().foregroundColor(Color.blue) : Circle().foregroundColor(Color.clear))
                        .frame(width: 22, height: 22)
                        .onTapGesture {
                            selectedOption = option.id
                        }
                }
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(selectedOption == option.id ? Color("borderColor") : Color.gray.opacity(0.5), lineWidth: 0.65)
                        .background(selectedOption == option.id ? Color.blue.opacity(0.2) : Color.clear)
                )
            }
            
            // "Попробовать бесплатно"
            Toggle(isOn: $isTrialEnabled) {
                Text("Попробовать бесплатно")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("ButtonColor")))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
    }
}
