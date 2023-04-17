//
//  ReviewScreen.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 17/04/23.
//

import SwiftUI

struct ReviewScreen: View {
    @StateObject var audioManager:AudioManager
    @Binding var path: [Route]
    
    @State var progress:Float
    @State var progressCounter: Int
    
    var topic: Topic
    var dialogues: [DialogueSentence]
    
    init(audioManager: AudioManager, path: Binding<[Route]>, topic: Topic) {
        self._audioManager = StateObject(wrappedValue: audioManager)
        self._path = path
        self._progress = State(wrappedValue: 0.0)
        self._progressCounter = State(wrappedValue: 0)
        self.topic = topic
        self.dialogues = getDialogue(topic.id)
    }
    
    var body: some View {
        let dialogue = dialogues[safe: progressCounter]
        
        VStack {
            HStack(spacing: 0) {
                CircularProgressView(progress: (Float(progressCounter + 1) / Float(dialogues.count)), circleLineWidth: 8, circleColor: Color("Blue500"), isTextVisible: false)
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding(.horizontal, 32)
            
            Spacer()
            
            Text(topic.title)
                .font(.system(size: 48, weight: .bold))
            
            VStack {
                GeometryReader { GeometryProxy in
                    ZStack() {
                        Text(dialogue?.text ?? "Index out of bound")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold))
                        
                        
                        Text("Click the box to replay the audio")
                            .foregroundColor(.white.opacity(0.6))
                            .position(x: GeometryProxy.size.width / 2, y: GeometryProxy.size.height - 20)
                    }
                }
            }
            .frame(width: 500, height: 250)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color("Blue500"))
            .cornerRadius(12)
            .onTapGesture {
                if audioManager.isPlaying {
                    audioManager.stopPlayback()
                } else {
                    audioManager.startPlaybackFromResources(key: dialogue?.soundKey ?? "", ext: "wav")
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    audioManager.startPlaybackFromResources(key: dialogue?.soundKey ?? "", ext: "wav")
                }
                
                audioManager.didFinishPlaying = {
                    audioManager.isPlaying = false
                }
            }
            .onChange(of: progressCounter) { newValue in
                let newDialog = dialogues[safe: newValue]
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    audioManager.startPlaybackFromResources(key: newDialog?.soundKey ?? "", ext: "wav")
                }
                
                audioManager.didFinishPlaying = {
                    audioManager.isPlaying = false
                }
            }
            
            VStack(spacing: 20) {
                Text(.init(dialogue?.meaning ?? ""))
                    .font(.system(size: 24, weight: .semibold))
                
                Text(.init(dialogue?.explanation ?? ""))
                    .font(.system(size: 24))
            }
            .padding(.top, 20)
            .frame(maxWidth: 500)
            
            Spacer()
            
            HStack(spacing: 20) {
                PromptButton(
                    title: "Prev", disabled: progressCounter == 0
                ) {
                    progressCounter -= 1
                }
                
                if progressCounter == dialogues.count - 1 {
                    PromptButton(title: "Finish") {
                       path = []
                    }
                } else {
                    PromptButton(title: "Next") {
                        progressCounter += 1
                    }
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

struct ReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewScreen(audioManager: AudioManager.shared, path: .constant([]), topic: Topic(id: "1", title: "Counting", description: "Learn how to count from one to ten in Balinese", explanation: "Knowing how to count up to ten in Balinese will make you able to tell how many stuff you need to local comfortably.", image: "123.rectangle.fill"))
    }
}
