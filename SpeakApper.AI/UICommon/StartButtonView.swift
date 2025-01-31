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
            Text(viewModel.currentPage < viewModel.steps.count - 1 ? "Продолжить" : "Начать")
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(viewModel.currentPage < viewModel.steps.count - 1 ? Color("ButtonColor") : Color("ButtonColor"))
                .cornerRadius(8)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal, 16)
        }
    }
}
