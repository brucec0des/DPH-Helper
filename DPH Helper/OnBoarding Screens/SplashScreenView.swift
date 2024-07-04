//
//  SplashScreenView.swift
//  DPH Helper
//
//  Created by Bruce Elliott on 7/4/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isNewAppLaunch = true
    @State private var size = 0.8
    @State private var opacity = 0.5
    @AppStorage("enrolled") var enrolled: Bool = false
    
    var body: some View {
        
        if isNewAppLaunch {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image("bhlogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.2)) {
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            self.isNewAppLaunch = false
                        }
                    }
                }
            }
            
        } else {
            MainView()
        }
    }
}

#Preview {
    SplashScreenView()
}
