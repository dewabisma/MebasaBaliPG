//
//  DialogueHeaderView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 06/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct DialogueHeaderView: View {
    @EnvironmentObject var audioManager:AudioManager
    
    @Binding var path: [Route]
    var progress:Float
    @Binding var isPresentingSheet:Bool
    
    var body: some View {
        HStack(spacing: 0) {
            CircularProgressView(progress: progress, circleLineWidth: 6, circleColor: Color("Blue500"), isTextVisible: false)
            
            Spacer()
            
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(maxHeight: .infinity)
                .scaledToFit()
                .foregroundColor(Color("Black400"))
                .onTapGesture {
                    isPresentingSheet.toggle()
                    audioManager.pausePlayback()
                }
                .transparentSheet(show: $isPresentingSheet) {
                    // onDismiss
                } content:{
                    PausePromptView(path:$path)
                        .environmentObject(audioManager)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal, 32)
    }
}

@available(iOS 16.0, *)
struct DialogueHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(false) { isPresenting in
            VStack(spacing: 0) {
                DialogueHeaderView(path: .constant([]),progress: 0.2, isPresentingSheet: isPresenting)
                
                Spacer()
            }
            .padding(.top, 32)
            .ignoresSafeArea(edges: .top)
        }
        
    }
}
