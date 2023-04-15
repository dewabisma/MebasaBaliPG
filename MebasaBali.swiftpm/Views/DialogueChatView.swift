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
    @Binding var dialogues: [DialogueSentence]
    @Binding var botIsTalking: Bool
    @Binding var progressCounter: Int
    
    @State var isHovered: Bool = false
    
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
                        .fill(.white)
                    LeafShapePointyLeft()
                        .stroke(.black, lineWidth: 2)
                    
                    
                case .right:
                    LeafShapePointyRight()
                        .fill(Color(hue: 0, saturation: 0, brightness: 0.7))
                    if isHovered {
                        LeafShapePointyRight()
                            .stroke(.black, lineWidth: 2)
                    }
                }
                
                VStack(spacing: 8) {
                    Text(dialogue.text)
                        .padding(.top, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                    
                    Text(dialogue.meaning)
                        .padding(.bottom, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                }
                
                
                if !dialogue.isBot && !dialogue.isAnswered {
                    LeafShapePointyRight()
                        .fill(Color(hue: 0, saturation: 0, brightness: 0.7))
                    
                    Text("Drop the correct word here!")
                }
            }
            .frame(width: 300, height: 150)
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
                            
                            print("url", url)
                            print("dialogue", dialogue.id)
                            if dialogue.id == "\(url)" {
                                progressCounter += 1
                                
                                withAnimation {
                                    dialogue.isAnswered = true
                                    
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
                } else {
                    action()
                }
            }
            .onAppear{
                if autoPlay {
                    action()
                    botIsTalking = true
                    
                    audioManager.didFinishPlaying = {
                        audioManager.isPlaying = false
                        botIsTalking = false
                        
                        if dialogue.isBot {
                            progressCounter += 1
                        }
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
        DialogueChatView(dialogue: .constant(DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd")), dialogues: .constant([DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd")]), botIsTalking: .constant(false),
                         progressCounter: .constant(1), pointy: .right) {
            
        }
        
        DialogueChatView(dialogue: .constant(DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd")), dialogues: .constant([DialogueSentence(soundKey: "dddd", text: "ddd", meaning: "ddd")]), botIsTalking: .constant(false),
                         progressCounter: .constant(1), pointy: .left) {
            
        }
    }
}

