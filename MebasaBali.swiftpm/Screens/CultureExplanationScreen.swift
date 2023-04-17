//
//  CultureExplanationScreen.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 15/04/23.
//

import SwiftUI

struct CultureExplanationScreen: View {
    @Binding var path: [Route]
    var topic: Topic
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color("Blue500"))
                    .frame(maxWidth: 350)
                    .shadow(color: Color("Blue300"), radius: 10)
//                Circle()
//                    .stroke(Color("Blue300"), lineWidth: 8)
//                    .frame(maxWidth: 350)
//                    .blur(radius: 8)
                
                Image(systemName: topic.image)
                    .font(.system(size: topic.id == "2" ? 150 : 200, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Text(topic.title)
                .font(.system(size: 40, weight: .bold))
            
            Text(.init(topic.explanation))
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            PromptButton(title: "Continue") {
                path.append(Route.dialogue(topic))
            }
            .padding(.bottom, 24)
        }
        .frame(maxWidth: 600)
    }
}

struct CultureExplanationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CultureExplanationScreen(path: .constant([]), topic: Topic(title: "Self Introduction", description: "dhwiahdih", explanation: "hehehehehe", image: "person.line.dotted.person.fill"))
    }
}
