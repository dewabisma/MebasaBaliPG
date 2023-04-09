//
//  NavTabView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct NavTabView: View {
    @State private var isPresentingView:Bool = false
    
    var body: some View {
        TabView {
            CoursesScreen(isPresentingNewView: $isPresentingView)
                .tabItem {
                    Label("Courses", systemImage: "graduationcap")
                }
            
            ProgressScreen()
                .tabItem {
                    Label("Progress", systemImage: "chart.xyaxis.line")
                }
        }
        .tint(.black)
        .fullScreenCover(isPresented: $isPresentingView) {
            DialogueScreen(isPresentingView: $isPresentingView)
        }
    }
}



struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}
