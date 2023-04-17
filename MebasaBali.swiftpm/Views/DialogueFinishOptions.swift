//
//  DialogFinishOptions.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 15/04/23.
//

import SwiftUI

struct DialogueFinishOptions: View {
    @Binding var path: [Route]
    var topic: Topic
    
    var body: some View {
        VStack {
            Text("Brilliant!")
                .padding(.top, 16)
                .padding(.bottom, 8)
                .font(.system(size: 32, weight: .bold))
            Text("You have learned some expression")
            Text("Let's review the words that you have learned")
            
            VStack(spacing: 16) {
                PromptButton(icon: "book", title: "Continue") {
                    path.append(Route.review(topic))
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
        }
        .frame(height: 300)
    }
}

struct DialogueFinishOptions_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            DialogueFinishOptions(path: .constant([]), topic: Topic(title: "dkwoadk", description: "dkwoakd", explanation: "dkwoakdo", image: "dkwoakdoakd"))
        }
    }
}
