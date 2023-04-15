//
//  DialogueScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

//import SwiftUI
//
//struct DialogueScreen: View {
//    @StateObject var audioManager = AudioManager.shared
//    
//    @State var progress:Float = 0.5
//    @State var progressCounter: Int = 0
//    @State var isPresentingSheet = false
//    @State var botIsTalking = true
//    @State var dialogues:[DialogueSentence] = [
//        DialogueSentence(soundKey: "a-sentences", text: "Om Swastiastu", meaning: "Polite Greeting, literally means may you be blessed by the Lord")
//    ]
//    
//    var userSentences: [DialogueSentence] = [
//        DialogueSentence(soundKey: "b-phrases", text: "rahajeng", meaning: "Welcome or greeting"),
//        DialogueSentence(soundKey: "b-sentences", text: "becik", meaning: "good or well"),
//    ]
//    var botSentences: [DialogueSentence] = [
//        DialogueSentence(soundKey: "a-phrases", text: "Punapi gatra?", meaning: "How are you?"),
//    ]
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            DialogueHeaderView(
//                progress: $progress,
//                isPresentingSheet: $isPresentingSheet
//            )
//            .padding(.vertical, 16)
//            
//            ScrollView {
//                VStack(spacing: 24) {
//                    ForEach(0..<dialogues.count, id: \.self) { index in
//                        let isBot = index == 0 || index % 2 == 0
//                        let isUser = index != 0 && index % 2 == 1
//                        let dialogue = dialogues[index]
//                        
//                        DialogueChatView(
//                            botIsTalking: $botIsTalking,
//                            message: dialogue.text,
//                            meaning: dialogue.meaning,
//                            soundKey: dialogue.soundKey,
//                            autoPlay: isBot,
//                            pointy: isUser ? .right : .left
//                        ) {
//                            if isUser {
//                                audioManager.startPlayback(key: "\(dialogue.soundKey).m4a")
//                                
//                                return
//                            }
//                            
//                            audioManager.startPlaybackFromResources(key: dialogue.soundKey)
//                        }
//                        .environmentObject(audioManager)
//                    }
//                }
//                .padding(.vertical, 32)
//                .padding(.horizontal, 24)
//                .frame(maxWidth: .infinity)
//            }
//            
//            if progressCounter < userSentences.count {
//                AnsweringBoxView(
//                    counter: $progressCounter,
//                    dialogues: $dialogues,
//                    botIsTalking: $botIsTalking,
//                    dialogue: userSentences[progressCounter],
//                    botSentences: botSentences
//                )
//                .environmentObject(audioManager)
//            } else {
//                Text("DONE TALKING").onTapGesture {
//                    isPresentingSheet = false
//                }
//            }
//        }
//        .onAppear {
//            audioManager.deleteAllAudios()
//            audioManager.getAudios()
//        }
//    }
//}
//
//struct DialogueScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DialogueScreen()
//    }
//}
