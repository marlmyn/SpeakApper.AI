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
                    
                    // Заголовок и иконка настроек
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
                    
                    // Поисковая строка
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    // Навигационные кнопки
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
                    
                    // Баннер (Premium)
                    BannerView()
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    // Список записей под баннером
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.filteredRecordings()) { recording in
                                RecordingRow(
                                    recording: recording,
                                    isPlaying: false,
                                    onPlay: {
                                        viewModel.playRecording(recording)
                                    },
                                    onDelete: {
                                        viewModel.deleteRecording(recording)
                                    }
                                )
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 16)
                    }
                    
                    Spacer()
                }
                .padding(.top, 16)
                
                // Кнопка микрофона по центру внизу с фоном
                VStack {
                    Spacer()
                    ZStack {
                        Button(action: {
                            isRecordingPresented = true
                        }) {
                            Image("Bttn")
                                .resizable()
                                .frame(width: 144, height: 144)
                                .foregroundColor(Color("micColor"))
                        }
                        .fullScreenCover(isPresented: $isRecordingPresented) {
                            RecordingView(isPresented: $isRecordingPresented, viewModel: viewModel, hasSavedRecording: $hasSavedRecording)
                        }
                    }
                    .padding(.bottom, 64)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .onAppear {
            viewModel.fetchRecordings()
        }
    }
}

#Preview {
    MainView()
}
