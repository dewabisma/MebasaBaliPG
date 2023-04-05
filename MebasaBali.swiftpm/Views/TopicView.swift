//
//  TopicView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct TopicView: View {
    var body: some View {
        HStack() {
            HStack() {
                VStack(alignment: .leading, spacing: 12) {
                    Text("The Essentials")
                        .font(.topicHeading)
                        
                    
                    Text("Understanding essential conversation in Balinese")
                }
                
                
                Spacer()
                
                VStack() {
                    Image(systemName: "book")
                        .font(.system(size: 32))
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
        .cornerRadius(24)
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TopicView()
        }
        .padding(.horizontal, 24)
    }
}
