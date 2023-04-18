//
//  DialogueChatView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

enum Pointy {
    case left, right
}

struct LeafShapePointyLeft: Shape {
    var cornerRadius: CGFloat = 24
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.minY)
        )
        
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius),
            control: CGPoint(x: rect.maxX, y: rect.minY)
        )
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.maxY)
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct LeafShapePointyRight: Shape {
    var cornerRadius: CGFloat = 24
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY),
            control: CGPoint(x: rect.maxX, y: rect.minY)
        )
        
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius),
            control: CGPoint(x: rect.minX, y: rect.minY)
        )
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY),
            control: CGPoint(x: rect.minX, y: rect.maxY)
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct DialogueChatView: View {
    @EnvironmentObject var audioManager:AudioManager
    
    @Binding var dialogue: DialogueSentence
    @Binding var userDialogues: [DialogueSentence]
    @Binding var botIsTalking: Bool
    @Binding var progressCounter: Int
    
    @State var isHovered: Bool = false
    @State var isPlaying: Bool = false
    @State var isWrong: Bool = false
    
    var autoPlay = false
    var pointy:Pointy = .left
    var action: () -> Void
    
    var body: some View {
        HStack {
            if pointy == .right {
                Spacer()
            }
            
            ZStack {
                switch (pointy) {
                case .left:
                    LeafShapePointyLeft()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.1 : 1)
                        .opacity(isPlaying ? 1 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.5).repeatForever().speed(1) : .easeIn(duration: 0.5), value: isPlaying)
                    LeafShapePointyLeft()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.2 : 1)
                        .opacity(isPlaying ? 0.6 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.4).delay(0.1).repeatForever() : .easeIn(duration: 0.4).delay(0.1), value: isPlaying)
                    LeafShapePointyLeft()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.3 : 1)
                        .opacity(isPlaying ? 0.3 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.3).delay(0.2).repeatForever() : .easeIn(duration: 0.3).delay(0.2), value: isPlaying)
                    LeafShapePointyLeft()
                        .fill(Color("Blue600"))
                    
                case .right:
                    LeafShapePointyRight()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.1 : 1)
                        .opacity(isPlaying ? 1 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.5).repeatForever().speed(1) : .easeIn(duration: 0.5), value: isPlaying)
                    LeafShapePointyRight()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.2 : 1)
                        .opacity(isPlaying ? 0.6 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.4).delay(0.1).repeatForever() : .easeIn(duration: 0.4).delay(0.1), value: isPlaying)
                    LeafShapePointyRight()
                        .fill(Color("Blue300"))
                        .scaleEffect(isPlaying ? 1.3 : 1)
                        .opacity(isPlaying ? 0.3 : 0)
                        .animation(isPlaying ? .easeIn(duration: 0.3).delay(0.2).repeatForever() : .easeIn(duration: 0.3).delay(0.2), value: isPlaying)
                    LeafShapePointyRight()
                        .fill(Color("Blue400"))
                    
                    if isHovered {
                        LeafShapePointyRight()
                            .stroke(Color("Blue600"), lineWidth: 4)
                    }
                }
                
                VStack(spacing: 8) {
                    Text(dialogue.text)
                        .padding(.top, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(dialogue.meaning)
                        .padding(.bottom, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.75))
                }
                
                
                if !dialogue.isBot && !dialogue.isAnswered {
                    LeafShapePointyRight()
                        .fill(Color("Blue400"))
                    
                    Text("Drop the correct word here!")
                        .foregroundColor(.white.opacity(0.75))
                }
            }
            .frame(width: 300, height: 150)
            .shake(percentage: isWrong ? 1 : 0)
            .onDrop(
                of: [.url],
                isTargeted: dialogue.isAnswered ? nil : $isHovered,
                perform: { providers in
                    if dialogue.isAnswered || dialogue.isBot {
                        return false
                    }
                    
                    if let first = providers.first {
                        let _ = first.loadObject(ofClass: URL.self) {
                            value, error in
                            
                            guard let url = value else {return}
                            
                            if dialogue.id == "\(url)" {
                                let index = userDialogues.firstIndex { item in
                                    item.id == dialogue.id
                                }
                                withAnimation {
                                    dialogue.isAnswered = true
                                    userDialogues[index!].isAnswered = true
                                    audioManager.stopPlayback()
                                    isPlaying = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    progressCounter += 1
                                }
                            } else {
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                                    isWrong = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        isWrong = false
                                    }
                                }
                            }
                        }
                    }
                    
                    return false
                })
            .onTapGesture {
                if audioManager.isPlaying {
                    audioManager.stopPlayback()
                    botIsTalking = false
                    isPlaying = false
                } else {
                    action()
                    isPlaying = true
                    
                    audioManager.didFinishPlaying = {
                        audioManager.isPlaying = false
                        botIsTalking = false
                        isPlaying = false
                    }
                }
            }
            .onAppear{
                if autoPlay {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        action()
                        botIsTalking = true
                        isPlaying = true
                    }
                }
                
                audioManager.didFinishPlaying = {
                    audioManager.isPlaying = false
                    botIsTalking = false
                    isPlaying = false
                    
                    if dialogue.isBot || dialogue.isAnswered {
                        progressCounter += 1
                    }
                }
            }
            
            if pointy == .left {
                Spacer()
            }
        }
    }
}

struct DialogueChatView_Previews: PreviewProvider {
    static var previews: some View {
        WithAudioManager()
    }
}

struct WithAudioManager:View {
    @StateObject var audioManager = AudioManager.shared
    
    var body: some View {
        VStack {
            DialogueChatView(dialogue: .constant(DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd", explanation: "kdowakodwkoa")), userDialogues: .constant([DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd", explanation: "dkwoakdowakodkwoad")]), botIsTalking: .constant(false),
                             progressCounter: .constant(1), pointy: .right) {
                
            }
                             .environmentObject(audioManager)
            
            DialogueChatView(dialogue: .constant(DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd", explanation: "dkwaodkoawkod")), userDialogues: .constant([DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd", explanation: "dkwoadkokaodkaw")]), botIsTalking: .constant(false),
                             progressCounter: .constant(1), pointy: .left) {
                
            }
                             .environmentObject(audioManager)
        }
    }
}
