//
//  Menu.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import SwiftUI

struct Menu: View {
    @AppStorage("coinCount") var coinCount = 100
    var body: some View {
        ZStack {
            Background(isLoadingBG: true)
            VStack(spacing: screenHeight*0.02) {
                Image("coinFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("RammettoOne-Regular", size: coinCount < 1000 ? screenHeight*0.07 : screenHeight*0.05))
                            .foregroundColor(.textcolor)
                            .shadow(color: .textshadow, radius: 2)
                            .shadow(color: .textshadow, radius: 2)
                            .offset(x:screenWidth*0.03)
                    )
                HStack(spacing: screenWidth*0.02) {
                    Image("castButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.2)
                    Image("trophyButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.2)
                }
                HStack(spacing: screenWidth*0.02) {
                    Image("shopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.2)
                    Image("guideButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.2)
                }
                Image("settingsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
            }
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
}

#Preview {
    Menu()
}
