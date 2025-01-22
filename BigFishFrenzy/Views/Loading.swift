//
//  Loading.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 20.01.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("levelInfo") var level = false
    @State private var loadingProgress:CGFloat = -0.24
    @State private var hookOffsetY: CGFloat = 0
    @State private var fishRotation: CGFloat = 0
    @State private var fishOffsetX: CGFloat = 0
    @State private var fishOffsetY: CGFloat = 0
    @State private var loadingOpacity: CGFloat = 1
    var body: some View {
        ZStack {
           Background(isLoadingBG: true)
            VStack {
                Spacer()
                Image("loadingFish")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.3)
                    .rotationEffect(Angle(degrees: fishRotation))
                    .offset(x:fishOffsetX, y:fishOffsetY)
                    
                Text("LOADING...")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.06))
                    .foregroundColor(.textcolor)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                Image("loadingBarBack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        Image("loadingBarFront")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.05)
                            .offset(x: screenWidth*loadingProgress)
                            .mask(
                                Image("loadingBarBack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            )
                    )
            }
            .opacity(loadingOpacity)
            Image("loadingHookLine")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.8)
                .offset(x: screenWidth*0.05, y: hookOffsetY)
        }
        .onAppear{
            AppDelegate().setOrientation(to: .landscapeLeft)
            loadingBarAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                hookAnimation()
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
//                coordinator.navigate(to: .main)
//            }
        }
        .onChange(of: level) { _ in
            if level {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    coordinator.navigate(to: .main)
                }
            }
        }
    }
    
    func loadingBarAnimation() {
        hookOffsetY = -screenHeight*0.9
        withAnimation(Animation.easeOut(duration: 3)) {
            loadingProgress = 0
        }
    }
    
    func hookAnimation() {
        withAnimation(Animation.easeOut(duration: 2)) {
            hookOffsetY = -screenHeight*0.3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.easeInOut(duration: 0.6)){
                hookOffsetY = -screenHeight
            }
            fishAnimation()
        }
    }
    
    func fishAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            fishOffsetX = screenWidth*0.05
            fishRotation = -90
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(Animation.easeInOut(duration: 0.6)) {
                fishOffsetY = -screenHeight
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(Animation.easeInOut(duration: 0.6)) {
                loadingOpacity = 0
            }
        }
    }
    
}

#Preview {
    Loading()
}
