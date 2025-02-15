//
//  MainView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI
import AVFoundation

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
                    headerView
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                    navigationItemsView
                    BannerView()
                        .padding(.horizontal)
                    recordingsListView
                    Spacer()
                }

                recordButton
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .onAppear {
            viewModel.fetchRecordings()
        }
    }

    private var headerView: some View {
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
    }

    private var navigationItemsView: some View {
        HStack(spacing: 36) {
            ForEach(navigationItems, id: \ .title) { item in
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
    }

    private var recordingsListView: some View {
        List {
            ForEach(viewModel.filteredRecordings()) { recording in
                NavigationLink(destination: RecordingDetailView(recording: recording)) {
                    recordingRow(for: recording)
                }
                .listRowBackground(Color("BackgroundColor"))
            }
            .onDelete(perform: deleteRecording)
        }
        .listStyle(PlainListStyle())
        .background(Color("BackgroundColor").ignoresSafeArea())
    }

    private func deleteRecording(at offsets: IndexSet) {
        offsets.forEach { index in
            let recording = viewModel.filteredRecordings()[index]
            viewModel.deleteRecording(recording)
        }
    }

    private func recordingRow(for recording: Recording) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.transcriptions[recording.url]?.components(separatedBy: " ").prefix(4).joined(separator: " ") ?? "Новая запись")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Text(recording.formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                        .font(.subheadline)

                    Text(getAudioDuration(for: recording))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
        .frame(height: 28)
        .padding()
        .background(Color("BackgroundColor"))
    }

    private func getAudioDuration(for recording: Recording) -> String {
        let asset = AVURLAsset(url: recording.url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)

        let minutes = Int(durationInSeconds) / 60
        let seconds = Int(durationInSeconds) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

    private var recordButton: some View {
        VStack {
            Spacer()
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
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    MainView()
}
