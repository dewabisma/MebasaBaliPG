//
//  PausePromptView.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 08/04/23.
//

import SwiftUI

struct PromptButton: View {
    var icon:String?
    var title:String
    var alignment: String = "trailing"
    var disabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                if disabled {
                    return
                }
                
                action()
            } label: {
                HStack(spacing: 16) {
                    if let icon = icon {
                        Image(systemName: icon)
                                .font(.system(size: 32, weight: .semibold, design: .rounded))
                    }
                    
                    Spacer()
               
                    Text(title)
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                    
                    if icon == nil {
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: 400)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(disabled ? Color(hue: 0, saturation: 0, brightness: 0.5) : Color("Blue500"))
                    .shadow(color: disabled ? Color(hue: 0, saturation: 0, brightness: 0.8) : Color("Blue400"), radius: 0, x: 0, y: 6)
            )
            .disabled(disabled)
        }
    }
}


@available(iOS 16.0, *)
struct PausePromptView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audioManager:AudioManager
    
    @Binding var path: [Route]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 0) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                HStack(spacing: 12) {
                    Text("You are doing great!")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    Text("Let's continue!")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color("Blue300"))
                }
                .font(.system(size: 18))
                .padding(.top, 12)
                .padding(.bottom, 32)
                
                VStack(spacing: 16) {
                    PromptButton(icon: "play.fill", title: "Continue Lesson") {
                        dismiss()
                        audioManager.resumePlayback()
                    }
                    
                    
                    PromptButton(icon: "door.left.hand.open", title: "Quit") {
                        audioManager.stopPlayback()
                        dismiss()
                        path = []
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(
                LinearGradient(colors: [Color("Blue600"), Color("Blue500")], startPoint: .bottom, endPoint: .top)
            )
            .onTapGesture {
                //
            }
        }
        .background(.black.opacity(0.000001))
        .onTapGesture {
            dismiss()
            audioManager.resumePlayback()
        }
        .gesture(
            DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    let direction = Swipe.direction(
                        width: value.translation.width,
                        height: value.translation.height
                    )
                    
                    switch(direction) {
                        case .down:
                            dismiss()
                            audioManager.resumePlayback()
                        default:
                            print("no clue")
                    }
                    
                }
        )
    }
}


@available(iOS 16.0, *)
struct PausePromptView_Previews: PreviewProvider {
    static var previews: some View {
        PausePromptView(path: .constant([]))
    }
}
