//
//  ViewExtensions.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 09/04/23.
//

import SwiftUI

extension View {
    func transparentSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) -> some View {
        self.fullScreenCover(isPresented: show, onDismiss: onDismiss) {
            content()
                .background(RemovebackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
