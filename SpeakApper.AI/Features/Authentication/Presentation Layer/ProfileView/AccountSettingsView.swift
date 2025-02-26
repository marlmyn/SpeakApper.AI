//
//  AccountSettingsView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 20.02.2025.
//

import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var authViewModel = AuthViewModel()
    
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
                    
                    Text("Настройки аккаунта")
                        .font(.system(size: 28).bold())
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(authViewModel.email)
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                        Text("Ваш адрес электронной почты")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Image("apple-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Войти через Apple")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }.padding(.leading, 16)
                    
                    Form {
                        Section(header: Text("Другое").textCase(nil).foregroundColor(.gray))  {
                            HStack {
                                SectionView(iconName: "delete-outline-rounded", title: "Удалить аккаунт")
                                Spacer()
                                Button(action: {
                                    Task {
                                        await authViewModel.deleteAccount()
                                        authViewModel.isLoggedIn = false
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text("Удалить")
                                        .foregroundColor(.red)
                                        .font(.system(size: 17))
                                }
                            }
                            Button(action: {
                                authViewModel.signOut()
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                SectionView(iconName: "logout", title: "Выйти")
                            }
                        }
                        .listRowBackground(Color("listColor"))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("BackgroundColor"))
                }
            }
        }
        .background(Color("BackgroundColor"))
        .foregroundStyle(.white)
        .navigationBarBackButtonHidden(true)
    }
}
