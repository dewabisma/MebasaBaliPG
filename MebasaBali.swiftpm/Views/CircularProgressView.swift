//
//  CircularProgressView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 08/04/23.
//

import SwiftUI

struct ViewIsVisible<Content: View>:View {
    var isVisible:Bool
    var content:() -> Content
    
    var body: some View {
        if isVisible {
            content()
        }
    }
}

struct CircularProgressView: View {
    @Binding var progress: Float
    
    var circleLineWidth:CGFloat = 30.0
    var circleColor:Color = .gray
    var textColor:Color = .black
    var isTextVisible = true
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: circleLineWidth)
                .opacity(0.5)
                .foregroundColor(circleColor)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: circleLineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(circleColor)
                .rotationEffect(.degrees(270))
                .animation(.linear, value: true)
                    
            
            ViewIsVisible(isVisible: isTextVisible) {
                Text(String(format: "%.0f %%", min(progress, 1.0) * 100.0))
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundColor(textColor)
            }
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            HStack {
                CircularProgressView(progress: .constant(0.0), circleColor: .blue)
            }
            .frame(width: 300, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.3))
        
    }
}
