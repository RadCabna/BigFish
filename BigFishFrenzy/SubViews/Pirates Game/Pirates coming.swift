//
//  Pirates coming.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct PiratesComing: View {
    @AppStorage("sound") private var sound = true
    @EnvironmentObject var coordinator: Coordinator
    @Binding var piratecIsComing: Bool
    @Binding var gameStage: Int
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    coordinator.navigate(to: .main)
                }
            VStack(spacing: screenHeight*0.03) {
                Image("piratesText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                Image("ticTacButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        gameStage = 6
                    }
                Image("rpsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        gameStage = 7
                    }
                Image("50Button")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        gameStage = 8
                    }
            }
            .offset(y: screenHeight*0.02)
        }
        
        .onAppear {
            if sound {
                SoundManager.instance.playSound(sound: "piratesSound1")
            }
        }
        
    }
}

#Preview {
    PiratesComing(piratecIsComing: .constant(true), gameStage: .constant(5))
}
