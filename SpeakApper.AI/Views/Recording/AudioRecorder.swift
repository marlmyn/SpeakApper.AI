//
//  AudioRecorder.swift
//  SpeakApper.AI
//
//  Created by Akmaral Ergesh on 08.02.2025.
//

import Foundation
import SwiftUI
import AVFoundation

//Observable class responsible for handling audio recording and playback
class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    @Published var recordings: [Recording] = []
    @Published var audioLevels: [CGFloat] = Array(repeating: 20, count: 30)
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    private var meterTimer: Timer?
    
    //Starts recording audio
    func startRecording() {
        // Настройка AVAudioSession
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
        } catch {
            print("Ошибка настройки аудио сессии: \(error.localizedDescription)")
            return
        }
        
        //
        let sequence = (recordings.last?.sequence ?? 0) + 1
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let dateString = formatter.string(from: Date())
        let fileName = "Recording_ \(sequence)_\(dateString).m4a"
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: path, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record() //Start recording
            
            print("Запись будет сохранена сюда: \(path)")
            
            //Start Meter Timer
            startMeterTimer()
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    //Stops the current recording session
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        
        //Start Meter Timer
        stopMeterTimer()
        fetchRecordings()
    }
    
    //fetches all recordings from the document directory
    func fetchRecordings() {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: [.creationDateKey], options: .skipsHiddenFiles)
            
            let fetchedRecordings = files.filter { $0.pathExtension == "m4a" }.compactMap { url -> Recording? in
                let attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
                let creationDate = attributes?[.creationDate] as? Date ?? Date()
                
                let fileName = url.lastPathComponent
                let components = fileName.split(separator: "_")
                let sequence = components.count > 1 ? Int(components[1]) ?? 0 : 0
                
                return Recording(url: url, date: creationDate, sequence: sequence)
            }
            recordings = fetchedRecordings.sorted(by: { $0.sequence < $1.sequence })
        } catch {
            print("Failed to fetch recordings: \(error.localizedDescription)")
        }
    }
    
    //Plays the selected recording
    func playRecording(url: URL, completion: @escaping(Bool) -> Void) {
        stopPlayback()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            completion(true)
        } catch {
            print("Failed to fetch recordings: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    //Stops the current playback
    func stopPlayback() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    
    //Deletes a specified recording
    //Parameter url: The URL of the recording to delete
    func deleteRecording(url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            fetchRecordings()
        } catch {
            print("Failed to delete recording: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Metering Timer
    
    //Starts the metering timer to update audio levels
    private func startMeterTimer() {
        meterTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.updateAudioLevels()
        }
    }
    
    //Stops the metering timer
    private func stopMeterTimer() {
        meterTimer?.invalidate()
        meterTimer = nil
    }
    
    //Updates the audio levels by reading from the audio recorder
    private func updateAudioLevels() {
        guard let recorder = audioRecorder else { return }
        recorder.updateMeters()
        let averagePower = recorder.averagePower(forChannel: 0)
        let normalizedLevel = self.normalizedPowerLevel(fromDecibels: averagePower)
        
        //Update the audioLevels array
        DispatchQueue.main.async {
            self.audioLevels.append(normalizedLevel)
            if self.audioLevels.count > 30 {
                self.audioLevels.removeFirst()
            }
        }
    }
    
    //Converts decibel power to a normalized level (0.0 - 1.0)
    private func normalizedPowerLevel(fromDecibels decibels: Float) -> CGFloat {
        if decibels < -80 {
            return 0.0
        } else if decibels >= 0 {
            return 1.0
        } else {
            let level = (decibels + 80) / 80
            return CGFloat(level)
        }
    }
    
    //MARK: - AVAudioRecorderDelegate Methods
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            fetchRecordings()
        } else {
            print("Recording was not successful.")
        }
    }
    
    //MARK: - AVAudioPlayerDelegate Methods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Notify that playback has finished
        NotificationCenter.default.post(name: .playbackFinished, object: nil)
    }
}

