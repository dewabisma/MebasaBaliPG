//
//  ContentView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 14/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
        NavigationStack {
            CoursesScreen()
        }
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
