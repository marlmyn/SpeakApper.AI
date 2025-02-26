//
//  SettingsView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 05.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var navigateToLogin = false
    @State private var showAccountSettings = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Назад")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .padding(.leading, 16)
                    }
                    .padding(.top, 10)
                    
                    Text("Настройки")
                        .font(.system(size: 28).bold())
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    //
                    HStack {
                        Button(action: {
                            if authViewModel.isLoggedIn {
                                showAccountSettings = true
                            } else {
                                navigateToLogin = true
                            }
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(authViewModel.email)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundStyle(.white)
                                    Text("Ваш аккаунт")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }.padding(.horizontal, 16)
                    //
                    Form {
                        //
                        Section(header: Text("Приложение").textCase(nil).foregroundColor(.gray)) {
                            NavigationLink(destination: ImportRecordView()) {
                                SectionView(iconName: "uil_import", title: "Импортировать файлы")
                            }
                            NavigationLink(destination: YoutubeView()) {
                                SectionView(iconName: "iconoir_youtube", title: "Youtube to text")
                            }
                            NavigationLink(destination: YoutubeView()) {
                                SectionView(iconName: "share-line", title: "Поделиться с другом")
                            }
                        }
                        .listRowBackground(Color("listColor"))
                        
                        Section(header: Text("Поддержка и обратная связь").textCase(nil).foregroundColor(.gray)) {
                            NavigationLink(destination: ImportRecordView()) {
                                SectionView(iconName: "message-outlined", title: "Отправить отзыв")
                            }
                            NavigationLink(destination: YoutubeView()) {
                                SectionView(iconName: "hugeicons_ai-idea", title: "Запросить функцию")
                            }
                            NavigationLink(destination: YoutubeView()) {
                                SectionView(iconName: "mingcute_question-line", title: "Вопросы и ответы")
                            }
                        }
                        .listRowBackground(Color("listColor"))
                        
                        Section(header: Text("Управление данными").textCase(nil).foregroundColor(.gray)) {
                            Button(action: {
                                // Удаление записей
                            }) {
                                HStack(spacing: 16) {
                                    Image("delete-outline-rounded")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.red)
                                    Text("Удалить все записи")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("(150 KB)")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .listRowBackground(Color("listColor"))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("BackgroundColor"))
                    .foregroundStyle(.white)
                    .navigationBarBackButtonHidden(true)
                    //
                    .onAppear {
                        Task {
                            await authViewModel.checkLoginStatus()
                        }
                    }
                    .onChange(of: authViewModel.isLoggedIn) { newValue in
                        print("isLoggedIn изменился:", newValue)
                        if !newValue && !authViewModel.navigateToAccountSettings {
                            navigateToLogin = true
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $showAccountSettings) {
                AccountSettingsView()
            }
        }
    }
}



#Preview {
    SettingsView()
}

struct SectionView: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 6)
    }
}
