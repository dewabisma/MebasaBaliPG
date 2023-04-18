//
//  ContentView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 14/04/23.
//

import SwiftUI

enum Route: Hashable {
    case dialogue(Topic)
    case explanation(Topic)
    case review(Topic)
}

@available(iOS 16.0, *)
struct RootView: View {
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            CoursesScreen(path: $path)
                .toolbar(.hidden, for: ToolbarPlacement.navigationBar)
                .navigationDestination(for: Route.self) { route in
                    switch(route) {
                        case let .dialogue(topic):
                            DialogueScreen(audioManager: AudioManager.shared, path: $path, topic: topic)
                            .toolbar(.hidden, for: ToolbarPlacement.navigationBar)
                        case let .explanation(topic):
                            CultureExplanationScreen(path: $path, topic: topic)
                    case let .review(topic):
                        ReviewScreen(audioManager: AudioManager.shared, path: $path, topic: topic)
                            .toolbar(.hidden, for: ToolbarPlacement.navigationBar)
                    }
                }
        }
    }
}


@available(iOS 16.0, *)
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
