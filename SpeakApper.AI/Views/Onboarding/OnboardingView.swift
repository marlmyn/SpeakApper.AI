//
//  ContentView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 25.01.2025.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(0..<viewModel.steps.count, id: \.self) { index in
                    viewModel.steps[index]
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            if viewModel.currentPage != 0 {
                PageControl(numberOfPages: viewModel.steps.count, currentPage: $viewModel.currentPage)
                    .padding(.top, -10)
            }

            if viewModel.currentPage != 3 {
                StartButtonView(viewModel: viewModel)
            }
        }
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}


#Preview {
    OnboardingView()
}
