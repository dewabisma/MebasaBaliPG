//
//  TopicView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct Topic {
    var title:String
    var description:String
    var image:String
}

struct TopicView: View {
    var topic: Topic
    
    var body: some View {
        HStack() {
            HStack() {
                VStack(alignment: .leading, spacing: 12) {
                    Text(topic.title)
                        .font(.topicHeading)
                        
                    Text(topic.description)
                }
                
                
                Spacer()
                
                VStack() {
                    Image(systemName: topic.image)
                        .font(.system(size: 32))
                }
            }
            .padding(24)
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
        .cornerRadius(24)
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TopicView(topic: Topic(title: "The Essentials", description: "Understanding essential conversation in Balinese", image: "book"))
        }
        .padding(.horizontal, 24)
    }
}
