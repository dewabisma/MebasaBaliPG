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
    
    @Binding var botIsTalking: Bool
    
    var message: String
    var meaning: String
    var soundKey: String
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
                }
                
                VStack(spacing: 8) {
                    Text(message)
                        .padding(.top, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                    
                    Text(meaning)
                        .padding(.bottom, 18)
                        .padding(.horizontal, 12)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                }
            }
//            .fixedSize(horizontal: false, vertical: true)
//            .frame(minWidth: 300, maxWidth: 300, maxHeight: 300)
            .frame(width: 300, height: 150)
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
                    botIsTalking = true
                    action()
                    
                    audioManager.didFinishPlaying = {
                        botIsTalking = false
                        audioManager.isPlaying = false
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
        DialogueChatView(botIsTalking: .constant(true), message: "Om Swastiastu  kdwokodkao dkwaokdoko kwodkao", meaning: "kodwkoadoka kodwakodkwoakod wkdoakdoakodkdwoako", soundKey: "hello.m4a", pointy: .right) {
            
        }
        
        DialogueChatView(botIsTalking: .constant(true), message: "Om Swastiastu ", meaning: "kodwkoadoka kodwakodkwoakod kdowkaodk", soundKey: "hello.m4a", pointy: .left) {
            
        }
    }
}

