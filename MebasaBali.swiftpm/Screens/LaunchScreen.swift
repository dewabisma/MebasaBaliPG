//
//  SwiftUIView.swift
//  
//
//  Created by Bisma Mahendra I Dewa Gede on 17/04/23.
//

import SwiftUI

struct LaunchScreen: View {
    @Binding var isLaunching: Bool
    @State var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 400)
                .shadow(color: Color("Blue300"), radius: isAnimating ? 24 : 0)
                .animation(.linear.repeatForever().speed(0.3), value: isAnimating)
            
                Text("MebasaBali")
                .font(.system(size: 88, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(color: Color("Blue300"), radius: isAnimating ? 24 : 0)
                .animation(.linear.repeatForever().speed(0.3), value: isAnimating)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color("Blue600"), Color("Blue500")], startPoint: .leading, endPoint: UnitPoint.trailing))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLaunching = false
            }
            
            isAnimating = true
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(isLaunching: .constant(true))
    }
}
