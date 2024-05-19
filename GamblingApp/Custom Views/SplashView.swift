//
//  SplashView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var logoOpacity = 0.0
    @State private var logoScale: CGFloat = 0.5
    
    var body: some View {
        VStack {
            if isActive {
                TabBarView()
            } else {
                ZStack {
                    Color(.charcoalBlack)
                        .ignoresSafeArea()
                    Image(ImageResource.mozzartLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .opacity(logoOpacity)
                        .scaleEffect(logoScale)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                self.logoOpacity = 1.0
                                self.logoScale = 1.0
                            }
                        }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
