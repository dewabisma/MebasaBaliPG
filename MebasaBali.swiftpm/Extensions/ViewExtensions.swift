//
//  ViewExtensions.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 09/04/23.
//

import SwiftUI

struct ShakeEffect: AnimatableModifier {
    var percentage: Double = 0

    var animatableData: Double {
        get { percentage }
        set { percentage = newValue }
    }

    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat(sin(percentage * 2 * .pi) * 10))
    }
}

extension View {
    func transparentSheet<Content: View>(show: Binding<Bool>, onDismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) -> some View {
        self.fullScreenCover(isPresented: show, onDismiss: onDismiss) {
            content()
                .background(RemovebackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func shake(percentage: Double) -> some View {
        modifier(ShakeEffect(percentage: percentage))
    }
}

fileprivate struct RemovebackgroundColor: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // function which is triggered when handleTap is called
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .black.withAlphaComponent(0.2)
        }
    }
}
