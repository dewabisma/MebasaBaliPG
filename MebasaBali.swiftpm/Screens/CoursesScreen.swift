//
//  CoursesScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct CoursesScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            // Heading
            HStack {
                VStack(alignment: .leading) {
                    Text("Om Swastiastu")
                    
                    Text("Courses")
                        .font(.title)
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
                    TopicView()
                    
                    TopicView()
                    
                    TopicView()
                    
                    TopicView()
                    
                    TopicView()
                    
                    TopicView()
                }
                .padding([.horizontal, .top], 24)
            }
           
            
        }

    }
}

struct CoursesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CoursesScreen()
    }
}
