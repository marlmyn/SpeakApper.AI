//
//  MainView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI
import AVFoundation

struct MainView: View {
    @StateObject private var recordingViewModel = RecordingViewModel()
    @StateObject private var viewModel: MainViewModel
    @State private var isRecordingPresented = false
    @State private var hasSavedRecording = false
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        _viewModel = StateObject(wrappedValue: MainViewModel(dependencies: dependencies))
    }
    
    var body: some View {
        contentBodyView
            .fullScreenCover(isPresented: $isRecordingPresented) {
                RecordingView(isPresented: $isRecordingPresented, viewModel: recordingViewModel, hasSavedRecording: $hasSavedRecording)
            }
    }
}

fileprivate extension MainView {
    var contentBodyView: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    headerView
                    
                    scrollableView
                    
                    Spacer()
                }
                .overlay(alignment: .bottom) {
                    VStack(spacing: 38) {
                        recordingTipView
                        
                        startRecordingButtonView
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 16)
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .settings:
                    SettingsView()
                case .import:
                    ImportRecordView()
                case .youtube:
                    YoutubeView()
                case .newFeature:
                    AIIdeaView()
                case .faq:
                    FAQView()
                }
            }
        }
    }

    var headerView: some View {
        HStack(spacing: 0) {
            Text("SpeakerApp")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.white)

            Spacer()

            NavigationLink(value: NavigationDestination.settings) {
                Image(.settings)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
    
    var scrollableView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                searchBarView
                
                buyPremiumView
                
                quickActionsView
                    .padding(.vertical, 16)
                
                recordingsView
            }
        }
    }
    
    var searchBarView: some View {
        HStack(spacing: 16) {
            Image(.mangnifyingglass)
            
            TextField("", text: $viewModel.searchText, prompt: Text("Поиск").foregroundColor(.white))
                .font(.system(size: 17))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 54)
        .background(Color("searchColor"))
        .cornerRadius(10)
    }
    
    var buyPremiumView: some View {
        HStack(spacing: 4) {
            Image(.premiumLightning)
            
            Text("Попробуйте SpeakApper Premium бесплатно\nНажмите, чтобы попробовать сейчас!")
                .font(.system(size: 15))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(
            LinearGradient(colors: [Color(hex: "#6D4BCC"), Color(hex: "#5B51C9"), Color(hex: "#9856EA")],
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .cornerRadius(10)
    }
    
    var quickActionsView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(QuickActionType.allCases, id: \.self) { actionType in
                NavigationLink(value: actionType.navigationDestination) {
                    QuickActionView(actionType: actionType)
                }
            }
        }
    }
    
    var recordingsView: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.recordingItemsViewModels, id: \.self) { viewModel in
                RecordingItemView(viewModel: viewModel)
            }
        }
    }
    
    var recordingTipView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Начните запись")
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(.white)
            
            Text("Просто нажмите кнопку и сделайте свою первую голосовую запись на...")
                .font(.system(size: 15))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.mainTipBackground.opacity(0.18))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.mainTipStrokeBorder, lineWidth: 0.5)
                )
        )
    }
    
    var startRecordingButtonView: some View {
        Button {
            isRecordingPresented.toggle()
        } label: {
            Image(.startRecordingButton)
                .overlay(alignment: .bottom) {
                    startRecordingButtonTipView
                        .offset(x: 0, y: 24)
                }
        }
    }
    
    var startRecordingButtonTipView: some View {
        Image(.startRecordingButtonTip)
    }

    var recordingsListView: some View {
        List {
            ForEach(recordingViewModel.filteredRecordings()) { recording in
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

    func deleteRecording(at offsets: IndexSet) {
        offsets.forEach { index in
            let recording = recordingViewModel.filteredRecordings()[index]
            recordingViewModel.deleteRecording(recording)
        }
    }

    func recordingRow(for recording: Recording) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(recordingViewModel.transcriptions[recording.url]?.components(separatedBy: " ").prefix(4).joined(separator: " ") ?? "Новая запись")
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

    func getAudioDuration(for recording: Recording) -> String {
        let asset = AVURLAsset(url: recording.url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)

        let minutes = Int(durationInSeconds) / 60
        let seconds = Int(durationInSeconds) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

    var recordButton: some View {
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
                RecordingView(isPresented: $isRecordingPresented, viewModel: recordingViewModel, hasSavedRecording: $hasSavedRecording)
            }
            .padding(.bottom, 32)
        }
    }
}
