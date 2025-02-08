//
//  MainView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var isRecordingPresented = false
    @State private var hasSavedRecording = false
    
    
    let navigationItems: [(image: String, title: String, destination: AnyView)] = [
        ("import", "Импорт записи", AnyView(ImportRecordView())),
        ("youtube", "Youtube", AnyView(YoutubeView())),
        ("ai-idea", "Запрос функции", AnyView(AIIdeaView())),
        ("faq", "FAQ", AnyView(FAQView()))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Text("SpeakerApp")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        NavigationLink(destination: SettingsView()) {
                            Image("settings")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    HStack(spacing: 36) {
                        ForEach(navigationItems, id: \.title) { item in
                            NavigationLink(destination: item.destination) {
                                VStack {
                                    Image(item.image)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text(item.title)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    BannerView()
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.filteredRecordings()) { recording in
                                RecordingRow(recording: recording)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 16)
                        
                        if !hasSavedRecording {
                            StartRecordingCard()
                                .padding(.bottom, 38)
                        }
                    }
                    
                    VStack {
                        Spacer()
                        RecordingButtonView(isRecordingPresented: $isRecordingPresented, hasSavedRecording: $hasSavedRecording)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 20)
                    }
                    
                }
                .padding(.top, 16)
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .fullScreenCover(isPresented: $isRecordingPresented) {
            RecordingView(isPresented: $isRecordingPresented, viewModel: viewModel, hasSavedRecording: $hasSavedRecording)
        }
    }
}

#Preview {
    MainView()
}
