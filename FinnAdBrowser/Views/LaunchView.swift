//
//  LaunchView.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 31/01/2024.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            Image("launch_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .scaleEffect(isAnimating ? 1.3 : 1.0)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
        }
    }
}

#Preview {
    LaunchScreenView()
}
