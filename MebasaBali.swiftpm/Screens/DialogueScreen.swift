//
//  DialogueScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct DialogueScreen: View {
    @StateObject var audioManager: AudioManager
    
    @Binding var path: [Route]
    var topic: Topic
    
    @State var progress: Float
    @State var progressCounter: Int
    @State var isPresentingSheet: Bool
    @State var botIsTalking: Bool
    @State var dialogues: [DialogueSentence]
    @State var userDialogues: [DialogueSentence]
    
    init(audioManager: AudioManager, path: Binding<[Route]>, topic: Topic) {
        self._audioManager = StateObject(wrappedValue: audioManager)
        self._path = path
        self.topic = topic
        self._progress = State(wrappedValue: 0.0)
        self._progressCounter = State(wrappedValue: 0)
        self._isPresentingSheet = State(wrappedValue: false)
        self._botIsTalking = State(wrappedValue: false)
        self._dialogues = State(wrappedValue: getDialogue(topic.id))
        self.userDialogues = self._dialogues.wrappedValue.filter({ dialog in
            !dialog.isBot
        }).shuffled()
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8, alignment: nil),
        GridItem(.flexible(), spacing: 8, alignment: nil),
        GridItem(.flexible(), spacing: 8, alignment: nil),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DialogueHeaderView(
                path: $path,
                progress: (Float(progressCounter) / Float(dialogues.count)),
                isPresentingSheet: $isPresentingSheet
            )
            .padding(.vertical, 16)
            .environmentObject(audioManager)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(0...min(progressCounter, dialogues.count - 1), id: \.self) { index in
                            let dialogue = $dialogues[index]
                            
                            DialogueChatView(
                                dialogue: dialogue,
                                userDialogues: $userDialogues,
                                botIsTalking: $botIsTalking,
                                progressCounter: $progressCounter,
                                autoPlay: true,
                                pointy: dialogue.isBot.wrappedValue ? .left : .right
                            ) {
                                audioManager.startPlaybackFromResources(key: dialogue.soundKey.wrappedValue, ext: "wav")
                            }
                            .environmentObject(audioManager)
                            .id(index)
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity)
                }
                .onChange(of: progressCounter) { newValue in
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
            
            if progressCounter < dialogues.count {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        Text("Drag the text according to the voice")
                        Text("Please press for a while until it's lifted before draging")
                        Text("Click the chat bubble to listen to the voice again")
                    }
                    .foregroundColor(.white)
                    
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(userDialogues, id: \.self) { dialogue in
                            Text(dialogue.text)
                                .frame(maxWidth:.infinity, minHeight: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.white)
                                )
                                .onDrag {
                                    return .init(contentsOf: URL(string: dialogue.id))!
                                }
                                .opacity(dialogue.isAnswered ? 0 : 1)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous).fill(dialogue.isAnswered ? Color("Blue500") : .clear)
                                }
                        }
                    }
                }
                .padding(24)
                .background(Color("Blue600"))
            } else {
                DialogueFinishOptions(path: $path, topic:topic)
            }
        }
    }
}

@available(iOS 16.0, *)
struct DialogueScreen_Previews: PreviewProvider {
    static var previews: some View {
        DialogueScreen(audioManager: AudioManager.shared, path: .constant([]), topic: Topic(title: "dwad", description: "dwad",explanation: "jeejje", image: "dwad"))
    }
}
