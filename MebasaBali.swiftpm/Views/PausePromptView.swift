//
//  PausePromptView.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 08/04/23.
//

import SwiftUI

struct PromptButton: View {
    var icon:String
    var title:String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button {
              action()
            } label: {
                HStack {
                    Image(systemName: icon)
                    
                    Spacer()
                    
                    Text(title)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray)
                    .shadow(color: .gray.opacity(0.6), radius: 0, x: 0, y: 6)
            )
        }
    }
}


struct PausePromptView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresentingView:Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 12) {
                Image(systemName: "globe")
                    .font(.system(size: 64))
                
                HStack {
                    Text("You are doing great!")
                    Text("Let's continue!")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 18))
                
                VStack(spacing: 16) {
                    PromptButton(icon: "play.fill", title: "Continue Lesson") {
                        dismiss()
                    }
                    
                    PromptButton(icon: "door.left.hand.open", title: "Quit") {
                        dismiss()
                        isPresentingView.toggle()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(
                Color(hue: 0, saturation: 0, brightness: 0.4)
            )
        }
        .background(.black.opacity(0.000001))
        .onTapGesture {
            dismiss()
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
                        default:
                            print("no clue")
                    }
                    
                }
        )
    }
    
    struct PausePromptView_Previews: PreviewProvider {
        static var previews: some View {
            StatefulPreviewWrapper(false) { value in
                PausePromptView(isPresentingView: value)
            }
        }
    }
}
