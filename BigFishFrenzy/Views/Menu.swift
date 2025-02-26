//
//  Menu.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import SwiftUI

struct Menu: View {
    @AppStorage("music") private var music = true
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    var body: some View {
        ZStack {
            Background(isLoadingBG: true)
            GeometryReader { geometry in
                let height = geometry.size.height
                let width = geometry.size.width
                let isLandscape = width > height
                if isLandscape {
                    VStack(spacing: height*0.02) {
                        Image("coinFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.2)
                            .overlay(
                                Text("\(coinCount)")
                                    .font(Font.custom("RammettoOne-Regular", size: coinCount < 1000 ? height*0.07 : height*0.05))
                                    .foregroundColor(.textcolor)
                                    .shadow(color: .textshadow, radius: 2)
                                    .shadow(color: .textshadow, radius: 2)
                                    .offset(x:width*0.03)
                            )
                        HStack(spacing: screenWidth*0.02) {
                            Image("castButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.2)
                                .onTapGesture {
                                    coordinator.navigate(to: .game)
                                }
                            Image("trophyButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.2)
                                .onTapGesture {
                                    coordinator.navigate(to: .trophy)
                                }
                        }
                        HStack(spacing: width*0.02) {
                            Image("shopButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.2)
                                .onTapGesture {
                                    coordinator.navigate(to: .shop)
                                }
                            Image("guideButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.2)
                                .onTapGesture {
                                    coordinator.navigate(to: .guidebook)
                                }
                        }
                        Image("settingsButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.2)
                            .onTapGesture {
                                coordinator.navigate(to: .settings)
                            }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
            if music {
                SoundManager.instance.playSound(sound: "mainMusic")
            }
        }
    }
}

#Preview {
    Menu()
}
