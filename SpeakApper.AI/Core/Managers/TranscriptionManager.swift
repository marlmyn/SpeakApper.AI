//
//  TranscriptionManager.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 12.02.2025.
//

import Foundation
import Speech

class TranscriptionManager: ObservableObject {
    @Published var transcriptions: [URL: String] = [:]

    // MARK: - Транскрипция аудиофайла
    func transcribeAudio(url: URL, completion: @escaping (String?) -> Void) {
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)

        // Проверка доступности распознавания
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
            SFSpeechRecognizer.requestAuthorization { status in
                if status == .authorized {
                    self.startRecognition(with: recognizer, request: request, url: url, completion: completion)
                } else {
                    print("Ошибка: нет разрешения на использование распознавания речи")
                    completion(nil)
                }
            }
            return
        }

        startRecognition(with: recognizer, request: request, url: url, completion: completion)
    }

    // MARK: - Начало процесса распознавания
    private func startRecognition(with recognizer: SFSpeechRecognizer?, request: SFSpeechURLRecognitionRequest, url: URL, completion: @escaping (String?) -> Void) {
        recognizer?.recognitionTask(with: request) { result, error in
            if let error = error {
                print("Ошибка транскрипции: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let result = result, result.isFinal {
                let transcription = result.bestTranscription.formattedString
                DispatchQueue.main.async {
                    self.transcriptions[url] = transcription
                }
                completion(transcription)
            }
        }
    }

    // MARK: - Проверка статуса разрешений
    func requestSpeechAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status == .authorized)
            }
        }
    }
}
