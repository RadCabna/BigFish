//
//  CoinGame.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct CoinGame: View {
    @AppStorage("sound") private var sound = true
    @State private var shipAngleRotation: CGFloat = 4
    @State private var chosenCoin = 0
    @Binding var gameStage: Int
    var body: some View {
        ZStack {
            Image("piratesShip")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .rotationEffect(Angle(degrees: shipAngleRotation))
                .offset(x: screenHeight*0.6)
            VStack(spacing: screenHeight*0.03) {
                Image(chosenCoin == 0 ? "choseSideText" : chosenCoin == 1 ? "headsText" : "tailsText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.07)
                HStack {
                    Image("backCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.3)
                        .opacity(chosenCoin == 2 ? 0.5 : 1)
                        .onTapGesture {
                            if sound {
                                SoundManager.instance.playSound(sound: "choseCoinSound")
                            }
                            chosenCoin = 1
                        }
                    Image("frontCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.3)
                        .opacity(chosenCoin == 1 ? 0.5 : 1)
                        .onTapGesture {
                            if sound {
                                SoundManager.instance.playSound(sound: "choseCoinSound")
                            }
                            chosenCoin = 2
                        }
                }
                Image("start50Button")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .opacity(chosenCoin == 0 ? 0.5 : 1)
                    .onTapGesture {
                        if sound {
                            SoundManager.instance.playSound(sound: "coinSound")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            gameStage = .random(in: 9...10)
                        }
                    }
            }
        }
        
        .onAppear {
            shipWobling()
        }
        
    }
    
    func shipWobling() {
        withAnimation(Animation.easeInOut(duration: 12).repeatForever(autoreverses: true)) {
            shipAngleRotation = -4
        }
    }
    
}

#Preview {
    CoinGame(gameStage: .constant(8))
}
