//
//  StartButtonView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 30.01.2025.
//

import SwiftUI

struct StartButtonView: View {
    @ObservedObject var viewModel: OnboardingViewModel 

    var body: some View {
        Button(action: {
            viewModel.nextPage()
        }) {
            Text("Продолжить")
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("ButtonColor"))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, 16)
        }
    }
}
