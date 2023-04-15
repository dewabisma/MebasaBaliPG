//
//  AnsweringBoxView.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 11/04/23.
//

import SwiftUI



struct ButtonIcon: View {
    var iconName:String
    var isDisabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconName)
                .foregroundColor(isDisabled ? .black.opacity(0.5) : .black)
                .font(.system(size: 24))
        }
        .padding(16)
        .background(
            Circle()
                .fill(
                    isDisabled ? Color(hue: 0, saturation: 0, brightness: 0.5).opacity(0.5) : Color(hue: 0, saturation: 0, brightness: 0.5)
                )
                .shadow(
                    color: .black.opacity(0.3), radius: 0, x: 0, y: 4
                )
        )
        .disabled(isDisabled)
    }
}

struct VoiceInputBarSkeleton: View {
    var body: some View {
        HStack {
            ButtonIcon(iconName: "speaker.wave.2.fill", isDisabled: true) {
            }
            
            Button {
            } label: {
                Image(systemName: "mic.fill")
                    .foregroundColor(.black.opacity(0.5))
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                Color(hue: 0, saturation: 0, brightness: 0.5).opacity(0.5)
                            )
                            .shadow(
                                color: .black.opacity(0.3), radius: 0, x: 0, y: 4
                            )
                    )
            }
            .disabled(true)
            
            ButtonIcon(iconName: "tortoise.fill", isDisabled: true) {
            }
        }
    }
    
}

struct VoiceInputBar: View {
    @EnvironmentObject var audioManager: AudioManager
    
    var soundKey: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            ButtonIcon(iconName: "speaker.wave.2.fill") {
                if audioManager.isPlaying {
                    audioManager.stopPlayback()
                } else {
                    audioManager.startPlaybackFromResources(key: soundKey)
                }
            }
            
            Button {
                action()
            } label: {
                Image(systemName: audioManager.isRecording ? "waveform": "mic.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                Color(hue: 0, saturation: 0, brightness: 0.5)
                            )
                            .shadow(
                                color: .black.opacity(0.3), radius: 0, x: 0, y: 4
                            )
                    )
                    .animation(
                        Animation.spring(blendDuration: 1),
                        value: audioManager.isRecording
                    )
            }
            
            ButtonIcon(iconName: "tortoise.fill") {
                if audioManager.isPlaying {
                    audioManager.stopPlayback()
                } else {
                    audioManager.startPlaybackSlowlyFromResources(key: soundKey)
                }
            }
        }
    }
}


struct AnsweringBoxView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    @Binding var counter: Int
    @Binding var dialogues: [DialogueSentence]
    @Binding var botIsTalking: Bool
    
    var dialogue: DialogueSentence
    var botSentences: [DialogueSentence]
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Word Box
            VStack {
                Text(botIsTalking ? "" : dialogue.text)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                Color(hue: 0, saturation: 0, brightness: 0.7)
            )
            .cornerRadius(12)
            
            // Meaning
            Text(botIsTalking ? "" : "\"\(dialogue.meaning)\"")
                .foregroundColor(.black.opacity(0.5))
            
            //Tool Bar
            if botIsTalking {
                VoiceInputBarSkeleton()
            } else {
                VoiceInputBar(
                    soundKey: dialogue.soundKey
                ) {
                    if audioManager.isRecording {
                        audioManager.stopRecording()
                    } else {
                        audioManager.startRecording(key: "\(dialogue.text).m4a")
                        audioManager.didFinishRecording = {
                            let newDialogue = DialogueSentence(soundKey: dialogue.text, text: dialogue.text, meaning: dialogue.meaning)
                            
                            dialogues.append(newDialogue)
                            
                            let isNotOutOfBound = botSentences.indices.contains(counter)
                            if let nextBotDialogue = isNotOutOfBound ? botSentences[counter] : nil {
                                dialogues.append(nextBotDialogue)
                            }
                            
                            counter += 1
                        }
                    }
                }.environmentObject(audioManager)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.gray)
        .alert(isPresented: $audioManager.isNotPermitted, content: {
            Alert(title: Text("Permission Error"), message: Text("Please enable mic permission"))
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(0) { num in
            StatefulPreviewWrapper([DialogueSentence(soundKey: "a-phrases", text: "Punapi gatra?", meaning: "How are you?")]) { dialogues in
                AnsweringBoxView(
                    counter: num,
                    dialogues: dialogues,
                    botIsTalking: .constant(false),
                    dialogue: DialogueSentence(soundKey: "a-phrases", text: "Punapi gatra?", meaning: "How are you?"),
                    botSentences: [DialogueSentence(soundKey: "a-phrases", text: "Punapi gatra?", meaning: "How are you?")])
            }
        }
    }
}
