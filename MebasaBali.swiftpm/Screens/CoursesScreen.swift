//
//  CoursesScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct CoursesScreen: View {
    
    let topics = [
        Topic(title: "Greeting", description: "Understanding greeting in Balinese", image: "book"),
        Topic(title: "Direction", description: "Understanding direction in Balinese", image: "book")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Heading
            HStack {
                VStack(alignment: .leading) {
                    Text("Om Swastiastu")
                    
                    Text("Courses")
                        .font(.largeTitle)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            
            // Divider
            Divider()
            
            // Topics
            ScrollView {
                VStack(spacing: 18) {
                    NavigationLink{
                        DialogueScreenExperiment().toolbar(.hidden, for: .navigationBar)
                    } label: {
                        TopicView(topic: topics[0])
                    }
                   
                    NavigationLink {
                        DialogueScreenExperiment().toolbar(.hidden, for: .navigationBar)
                    } label: {
                        TopicView(topic: topics[1])
                    }
                }
                .padding([.horizontal, .top], 24)
            }
        }
    }
}

@available(iOS 16.0, *)
struct CoursesScreen_Previews: PreviewProvider {
    static var previews: some View {
       CoursesScreen()
    }
}


