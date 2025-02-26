//
//  AuthCodeView.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 20.02.2025.
//

import SwiftUI

struct AuthCodeView: View {
    @StateObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToSettings = false
//    @Binding var navigateToSettings: Bool

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading) {
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
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                Text("Проверьте электронную почту")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 16)

                Text("Мы отправили письмо на адрес \(authViewModel.email). Перейдите по ссылке в письме или введите код. Срок действия кода истекает через 5 минут.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray.opacity(0.7))
                    .padding(.bottom, 16)
                
                TextField("Код авторизации", text: $authViewModel.otpCode)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                    .foregroundColor(.white)
                    .padding(.bottom, 16)

                Button(action: {
                    Task {
                        await authViewModel.verifyOTP(email: authViewModel.email, code: authViewModel.otpCode)
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
                .disabled(authViewModel.otpCode.isEmpty)
                .opacity(authViewModel.otpCode.isEmpty ? 0.5 : 1.0)
                .padding(.top, 16)

                if let error = authViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            authViewModel.otpCode = ""
        }
        .onChange(of: authViewModel.navigateToAccountSettings) { newValue in
            if newValue {
                DispatchQueue.main.async {
                    authViewModel.navigateToAccountSettings = false
                    navigateToSettings = true
                }
            }
        }
        .onDisappear {
            authViewModel.navigateToAccountSettings = false
        }
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: SettingsView(), isActive: $navigateToSettings) {
                EmptyView()
            })
    }
}


