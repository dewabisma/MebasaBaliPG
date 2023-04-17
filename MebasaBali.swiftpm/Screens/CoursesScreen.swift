//
//  CoursesScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct CoursesScreen: View {
    @Binding var path: [Route]
    let topics:[Topic] = loadJson("topics")
    
    var body: some View {
        VStack(spacing: 0) {
            // Heading
            VStack {
                HStack {

                    VStack(alignment: .leading) {
                        Text("Om Swastiastu")
                        
                        Text("Courses")
                            .font(.largeTitle)
                    }
                    .foregroundColor(Color("Black400"))
                    
                    Spacer()
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 75)
                }
                .padding(.horizontal, 24)
               
                Divider()
            }

            .padding(.bottom, 8)
            
            // Topics
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(topics) { topic in
                        NavigationLink(value: Route.explanation(topic)) {
                            TopicView(topic: topic)
                        }
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
        CoursesScreen(path: .constant([]))
    }
}


