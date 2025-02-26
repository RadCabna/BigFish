//
//  YouWinPirates.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct YouWinPirates: View {
    @AppStorage("sound") private var sound = true
    @EnvironmentObject var coordinator: Coordinator
    @Binding var gameStage: Int
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            Image("pirate")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.8)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            Image("bottomBlur")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    coordinator.navigate(to: .main)
                }
            VStack {
                Image("fishingText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                Spacer()
                Image("continueFishingButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        gameStage = 0
                    }
            }
            .padding(.vertical)
        }
        
        .onAppear {
            if sound {
                SoundManager.instance.playSound(sound: "piratesLostSound")
            }
        }
        
    }
}

#Preview {
    YouWinPirates(gameStage: .constant(9))
}
