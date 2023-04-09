//
//  DialogueScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct ButtonIcon: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "speaker.wave.2.fill")
                .foregroundColor(.black)
                .font(.system(size: 24))
        }
        .padding(16)
        .background(
            Circle()
                .fill(
                    Color(hue: 0, saturation: 0, brightness: 0.5)
                )
                .shadow(
                    color: .black.opacity(0.3), radius: 0, x: 0, y: 4
                )
        )
    }
}

struct VoiceInputBar: View {
    var body: some View {
        HStack {
            ButtonIcon()
            
            Button {
                
            } label: {
                Image(systemName: "mic.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 32))
            }
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
            
            ButtonIcon()
        }
    }
}

struct AnsweringBox: View {
    var body: some View {
        VStack(spacing: 20) {
            // Word Box
            VStack {
                Text("Om Swastiastu")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                Color(hue: 0, saturation: 0, brightness: 0.7)
            )
            .cornerRadius(12)
            
            // Meaning
            Text("\"May you be blessed by the lord\"")
                .foregroundColor(.black.opacity(0.5))
            
            //Tool Bar
            VoiceInputBar()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.gray)
    }
}

struct DialogueScreen: View {
    @Binding var isPresentingView:Bool
    
    @State var progress:Float = 0.0
    @State var isPresentingSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            DialogueHeaderView(progress: $progress)
                .onTapGesture {
                    isPresentingSheet.toggle()
                }
                .transparentSheet(.init(.ultraThinMaterial), show: $isPresentingSheet) {
                    // onDismiss
                } content:{
                    PausePromptView(isPresentingView: $isPresentingView)
                    
                }
            
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        DialogueChatView()
                                .frame(maxWidth: 200)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        DialogueChatView()
                            .frame(maxWidth: 200)
                    }
                    
                    HStack {
                        DialogueChatView()
                                .frame(maxWidth: 200)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        DialogueChatView()
                            .frame(maxWidth: 200)
                    }
                    
                    HStack {
                        DialogueChatView()
                                .frame(maxWidth: 200)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        DialogueChatView()
                            .frame(maxWidth: 200)
                    }
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
            }
            
            AnsweringBox()
        }
    }
}

struct DialogueScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(false) { value in
            DialogueScreen(isPresentingView: value)
        }
    }
}
