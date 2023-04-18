//
//  File.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 11/04/23.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate, ObservableObject {
    static let shared = AudioManager()
    
    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var isPaused = false
    @Published var playedKey: String?
    @Published var isNotPermitted = false
    @Published var userVoices:[URL] = []
    
    var audioSession: AVAudioSession?
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var didFinishPlaying: (() -> Void)?
    var didFinishRecording: (() -> Void)?
    
    private override init() {
        super.init()
        
        // Set up audio session
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession?.setCategory(.playback)
            //            try audioSession?.setActive(true)
            
//            audioSession?.requestRecordPermission({ status in
//                if !status {
//                    self.isNotPermitted.toggle()
//                } else {
//                    self.getAudios()
//                }
//            })
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func startRecording(key: String) {
        guard audioSession != nil else {
            print("Audio session not set up")
            return
        }
        
        if isRecording {
            print("Already recording")
            return
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(key)")
        
        print(key, audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error starting recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        if !isRecording {
            print("Not recording")
            return
        }
        
        print("Stop recording")
        audioRecorder?.stop()
        isRecording = false
        getAudios()
    }
    
    func startPlaybackFromResources(key: String, ext: String = "m4a") {
        guard audioSession != nil else {
            print("Audio session not set up")
            return
        }
        
        if let audioFilename = Bundle.main.url(forResource: key, withExtension: ext) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.delegate = self
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
                
                print("Starting playback")
            } catch {
                print("Error starting playback: \(error.localizedDescription)")
            }
        }
    }
    
    func startPlayback(key: String) {
        guard audioSession != nil else {
            print("Audio session not set up")
            return
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(key)")
        
        print(key, audioFilename)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            
            print("Starting playback")
        } catch {
            print("Error starting playback: \(error.localizedDescription)")
        }
    }
    
    func startPlaybackSlowlyFromResources(key: String, ext: String = "m4a") {
        guard audioSession != nil else {
            print("Audio session not set up")
            return
        }
        
        if let audioFilename = Bundle.main.url(forResource: key, withExtension: ext) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.delegate = self
                audioPlayer?.enableRate = true
                audioPlayer?.rate = 0.5
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
                
                print("Starting playback")
            } catch {
                print("Error starting playback: \(error.localizedDescription)")
            }
        }
    }
    
    func startPlaybackSlowly(key: String) {
        guard audioSession != nil else {
            print("Audio session not set up")
            
            return
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(key)")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.enableRate = true
            audioPlayer?.rate = 0.5
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            
            print("Starting playback")
        } catch {
            print("Error starting playback: \(error.localizedDescription)")
        }
    }
    
    func resumePlayback() {
        guard isPaused else {
            print("No paused playback")
            return
        }
        
        audioPlayer?.play()
        print("Resuming playback")
    }
    
    func pausePlayback() {
        guard isPlaying else {
            print("Currently no audio is played")
            return
        }
        
        audioPlayer?.pause()
        isPaused = true
        
        print("Pausing playback")
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
        
        print("Stopping playback")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getAudios() {
        do {
            let url = getDocumentsDirectory()
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            userVoices.removeAll()
            
            for i in result {
                userVoices.append(i)
            }
        } catch {
            print("Error reading audio directory: \(error.localizedDescription)")
        }
    }
    
    func deleteAllAudios() {
        do {
            let url = getDocumentsDirectory()
            let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            for i in directoryContents {
                print("Deleting: \(i.relativePath)")
                
                deleteAudio(key: i.relativePath)
                
                print("Success deleting: \(i.relativePath)")
            }
        } catch {
            print("Error deleting: \(error.localizedDescription)")
        }
    }
    
    func deleteAudio(key: String) {
        do {
            let url = getDocumentsDirectory()
            let fileUrl = url.appendingPathComponent("\(key)")
            
            try FileManager.default.removeItem(at: fileUrl)
        } catch {
            print("Error deleting: \(error.localizedDescription)")
        }
    }
    
    // MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Finished recording successfully")
            
            didFinishRecording?()
        } else {
            print("Finished recording with error")
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let error = error {
            print("Error during recording: \(error.localizedDescription)")
        }
    }
    
    // MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Finished playing audio successfully")
            isPaused = false
            didFinishPlaying?()
        } else {
            print("Finished playing audio with error")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Error during playing audio: \(error.localizedDescription)")
        }
    }
}

