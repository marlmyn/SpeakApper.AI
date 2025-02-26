//
//  LoginView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 20.02.2025.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var navigateToOTP = false
    @StateObject private var authViewModel = AuthViewModel()
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Кнопка "Назад"
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                }
                .padding(.top, 10)
                
                // Заголовок
                Text("Войдите в SpeakApper")
                    .font(.system(size: 21).weight(.bold))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                // Подзаголовок
                Text("Храните файлы в безопасности и синхронизируйте их на всех устройствах")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
                // Поле ввода email
                TextField("Ваш адрес эл. почты", text: $email)
                    .padding()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .foregroundStyle(.white)
                    .padding(.bottom, 16)
                
                // Кнопка "Продолжить"
                Button(action: {
                    authViewModel.email = email
                    Task {
                        await authViewModel.sendOTP(to: email)
                        navigateToOTP = true
                    }
                }) {
                    Text("Продолжить")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("ButtonColor"))
                        .cornerRadius(10)
                }
                .disabled(email.isEmpty)
                .opacity(email.isEmpty ? 0.5 : 1.0)
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                    Text("ИЛИ")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.vertical, 16)
                
                // Кнопка "Продолжить с Apple"
                Button(action: {
                    // Действие при нажатии через Apple ID
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.headline)
                        Text("Продолжить с Apple")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: AuthCodeView(authViewModel: authViewModel), isActive: $navigateToOTP) { EmptyView() }
        )
    }
}

#Preview {
    LoginView()
}


