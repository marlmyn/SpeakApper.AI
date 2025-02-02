//
//  MainView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 02.02.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    SearchBar(text: $viewModel.searchText)
                        .padding(.bottom, 24)
                    
                    HStack {
                        NavigationButton(title: "Импорт записи", icon: "import")
                        NavigationButton(title: "YouTube", icon: "youtube")
                        NavigationButton(title: "Запрос функции", icon: "ai-idea")
                        NavigationButton(title: "FAQ", icon: "faq")
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    BannerView()
                        .padding(.bottom, 8)
                    List(viewModel.filteredRecordings()) { recording in
                        RecordingRow(recording: recording)
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color("BackgroundColor"))
                    
                    Spacer()
                    
                    RecordButton()
                }
                .navigationBarItems(trailing: Button(action: {
                    print("Открыть настройки")
                }) {
                    Image("settings")
                        .resizable()
                        .scaledToFit()
                })
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("SpeakerApp")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                }
                
                
            }
        }
    }
}
#Preview {
    MainView()
}
