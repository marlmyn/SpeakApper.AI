//
//  AuthViewModel.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 20.02.2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = UserDefaults.standard.string(forKey: "userEmail") ?? "Гость"
    @Published var otpCode: String = ""
    @Published var isOtpSent: Bool = false
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
    @Published var errorMessage: String?
    @Published var navigateToSettings: Bool = false
    @Published var navigateToAccountSettings: Bool = false
    @Published var navigateToLogin: Bool = false
    
    
    private let db = Firestore.firestore()

    
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        Task {
            await checkLoginStatus()
        }
    }

    
    func sanitizeEmail(_ email: String) -> String {
        return email.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ".", with: "_")
    }
    
    func sendOTP(to email: String) async {
        let sanitizedEmail = sanitizeEmail(email)
        guard !sanitizedEmail.isEmpty else {
            self.errorMessage = "Введите email"
            return
        }
        
        let otp = String(Int.random(in: 100000...999999))
        let expirationTime = Date().addingTimeInterval(300)
        
        let data: [String: Any] = [
            "email": email,
            "otp": otp,
            "timestamp": Timestamp(date: expirationTime)
        ]
        
        do {
            try await db.collection("otp_codes").document(sanitizedEmail).setData(data)
            self.isOtpSent = true
            print("OTP-код \(otp) сохранен в Firestore")
        } catch {
            self.errorMessage = "Ошибка отправки OTP"
        }
    }
    
    func verifyOTP(email: String, code: String) async {
        let sanitizedEmail = sanitizeEmail(email)
        guard !sanitizedEmail.isEmpty else {
            self.errorMessage = "Введите email"
            return
        }

        do {
            let snapshot = try await db.collection("otp_codes").document(sanitizedEmail).getDocument()
            
            if let data = snapshot.data(), let storedOTP = data["otp"] as? String, storedOTP == code {
                await signInUser(email: email)

                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.navigateToAccountSettings = true
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    print("OTP-код подтвержден, должно открыться SettingsView")
                }
            } else {
                self.errorMessage = "Неверный код"
            }
        } catch {
            self.errorMessage = "Ошибка проверки OTP"
        }
    }


    func signInUser(email: String) async {
        do {
            let auth = Auth.auth()
            let existingUser = try? await auth.fetchSignInMethods(forEmail: email)

            if let methods = existingUser, !methods.isEmpty {
                let newPassword = UUID().uuidString
                let user = try await auth.signIn(withEmail: email, password: newPassword)
                
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.email = user.user.email ?? "Гость"
                    UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
                    UserDefaults.standard.set(self.email, forKey: "userEmail")
                }
            } else {
                let result = try await auth.createUser(withEmail: email, password: UUID().uuidString)
                
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.email = result.user.email ?? "Гость"
                    UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
                    UserDefaults.standard.set(self.email, forKey: "userEmail")
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Ошибка входа"
            }
        }
    }
    
    
    func checkLoginStatus() async {
        await MainActor.run {
            self.isLoggedIn = Auth.auth().currentUser != nil
            self.email = Auth.auth().currentUser?.email ?? "Гость"
            UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
            UserDefaults.standard.set(self.email, forKey: "userEmail")
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.email = "Гость"
            UserDefaults.standard.removeObject(forKey: "userEmail")
            print("Пользователь вышел из аккаунта")
        } catch {
            self.errorMessage = "Ошибка выхода"
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "Пользователь не найден"
            return
        }

        do {
            try await db.collection("users").document(user.uid).delete()
            try await user.delete()

            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.email = "Гость"
                UserDefaults.standard.removeObject(forKey: "userEmail")
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                self.navigateToSettings = false
            }

            print("Аккаунт удален")
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Ошибка удаления аккаунта"
            }
        }
    }
}

