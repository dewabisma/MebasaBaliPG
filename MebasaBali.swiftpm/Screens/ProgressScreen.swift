//
//  ProgressScreen.swift
//  MebasaBali
//
//  Created by Bisma Mahendra I Dewa Gede on 05/04/23.
//

import SwiftUI

struct TextWithUnit: View {
    var value: String
    var unit: String
    var spacing: CGFloat = 4
    
    var body: some View {
        HStack(alignment: .bottom, spacing: spacing) {
            Text(value)
                .font(.statValue)
                .offset(x: 0, y: 1.5)
            
            Text(unit)
        }
    }
}

struct StatView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "flame.fill")
                .font(.system(size: 28))
                .padding(24)
                .background(.gray)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4) {
                TextWithUnit(value:"1", unit: "day")
            
                Text("Longest Streak")
                    .font(.statDescription)
                    .textCase(.uppercase)
                    .foregroundColor(.black.opacity(0.5))
            }
        }
    }
}

struct ProgressScreen: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 100)
            
            
            Text("Balinese Journey")
                .font(.largeTitle)
        
            // Learning Duration
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    TextWithUnit(value: "28", unit: "m", spacing: 0)
                    TextWithUnit(value: "28", unit: "s", spacing: 0)
                }

                
                Text("Talking in Balinese")
                    .font(.system(size: 14, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundColor(.black.opacity(0.3))
            }
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(.gray)
            .cornerRadius(12)
            
            // Learning Stats
            VStack {
                // Stat
                StatView()
                
                StatView()
                
                StatView()
                
                
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ProgressScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProgressScreen()
    }
}
