//
//  NavTabView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct NavTabView: View {
    init() {
        // Customize the appearance of the navigation bar
        UINavigationBar.appearance().backgroundColor = .red
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        TabView {
            CoursesScreen()
                .tabItem {
                    Label("Courses", systemImage: "graduationcap")
                }
            
            ProgressScreen()
                .tabItem {
                    Label("Progress", systemImage: "chart.xyaxis.line")
                }
        }.tabViewStyle(DefaultTabViewStyle())
    }
}



struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}
