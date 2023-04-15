//
//  DialogueScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct DialogueScreenExperiment: View {
    @StateObject var audioManager = AudioManager.shared
    
    @State var progress: Float = 0.0
    @State var progressCounter: Int = 0
    @State var isPresentingSheet = false
    @State var botIsTalking = true
    @State var dialogues: [DialogueSentence] = dialogues_
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8, alignment: nil),
        GridItem(.flexible(), spacing: 8, alignment: nil),
        GridItem(.flexible(), spacing: 8, alignment: nil),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DialogueHeaderView(
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
                                dialogues: $dialogues,
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
                        Text("Please drag the text according to the voice")
                        Text("Click the chat box to listen to the voice again")
                    }
                    
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(dialogues.filter({ dialog in
                            !dialog.isBot
                        }), id: \.self) { dialogue in
                            Text(dialogue.text)
                                .frame(maxWidth:.infinity, minHeight: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hue: 0, saturation: 0, brightness: 0.7))
                                )
                                .onDrag {
                                    return .init(contentsOf: URL(string: dialogue.id))!
                                }
                                .opacity(dialogue.isAnswered ? 0 : 1)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous).fill(dialogue.isAnswered ? .gray.opacity(0.25) : .clear)
                                }
                        }
                    }
                }
                .padding(24)
                .background(Color(hue: 0, saturation: 0, brightness: 0.8))
            } else {
                VStack {
                    NavigationLink(destination: ContentView()) {
                        Text("Dialogue is finished")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
            }
        }
    }
}

@available(iOS 16.0, *)
struct DialogueScreenExperiment_Previews: PreviewProvider {
    static var previews: some View {
        DialogueScreenExperiment()
    }
}
