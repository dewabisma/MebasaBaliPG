//
//  TopicView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct TopicView: View {
    var topic: Topic
    
    var body: some View {
        HStack() {
            HStack() {
                VStack(alignment: .leading, spacing: 12) {
                    Text(topic.title)
                        .font(.topicHeading)
                        
                    Text(topic.description)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 200)
                
                Image(systemName: topic.image)
                    .font(.system(size: 40))
            }
            .padding(24)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color("Blue600"))
        .cornerRadius(24)
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TopicView(topic: Topic(title: "The Essentials", description: "Understanding essential conversation in Balinese",explanation: "dkowakodwakodko", image: "book"))
        }
        .padding(.horizontal, 24)
    }
}
