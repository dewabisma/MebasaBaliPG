import SwiftUI

@available(iOS 16.0, *)
@main
struct MyApp: App {
    @State private var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                LaunchScreen(isLaunching: $isLaunching)
                    .transition(.opacity)
            } else {
                RootView()
                    .transition(.opacity)
            }
        }
    }
}
