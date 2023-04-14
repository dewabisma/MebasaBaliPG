//
//  DialogueHeaderView.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 06/04/23.
//

import SwiftUI

struct DialogueHeaderView: View {
    @Binding var progress:Float
    @Binding var isPresentingSheet:Bool
    
    var body: some View {
        HStack(spacing: 0) {
            CircularProgressView(progress: $progress, circleLineWidth: 4, isTextVisible: false)
            
            Spacer()
            
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(maxHeight: .infinity)
                .scaledToFit()
                .onTapGesture {
                    isPresentingSheet.toggle()
                }
                .transparentSheet(show: $isPresentingSheet) {
                    // onDismiss
                } content:{
                    PausePromptView()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: 25)
        .padding(.horizontal, 32)
    }
}

struct DialogueHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(0.2) { progress in
            StatefulPreviewWrapper(false) { isPresenting in
                VStack(spacing: 0) {
                    DialogueHeaderView(progress: progress, isPresentingSheet: isPresenting)
                    
                    Spacer()
                }
                .padding(.top, 32)
                .ignoresSafeArea(edges: .top)
            }
        }
    }
}
