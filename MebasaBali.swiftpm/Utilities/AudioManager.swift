//
//  File.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 11/04/23.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    static let shared = AudioManager()
    
    @Published var isPlaying = false
    @Published var isPaused = false
    @Published var playedKey: String?
    
    var audioSession: AVAudioSession?
    var audioPlayer: AVAudioPlayer?
    var didFinishPlaying: (() -> Void)?
    
    private override init() {
        super.init()
        
        // Set up audio session
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession?.setCategory(.playback)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func startPlaybackFromResources(key: String, ext: String = "wav") {
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
    
    // MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Finished playing audio successfully")
            isPaused = false
            isPlaying = false
            
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

