//
//  RPS.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct RPS: View {
    @AppStorage("sound") private var sound = true
    @State private var yourImage = "questionMark"
    @State private var enemyImage = "questionMark"
    @State private var shipAngleRotation: CGFloat = 4
    @Binding var gameStage: Int
    var soundsArray = ["xoSound1", "xoSound2", "xoSound3"]
    var rpsArray = ["rock", "paper", "scissors"]
    var body: some View {
        ZStack {
            Image("piratesShip")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .rotationEffect(Angle(degrees: shipAngleRotation))
                .offset(x: screenHeight*0.6)
            VStack {
                Image("rpsPlate")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.5)
                    .overlay (
                        ZStack {
                            VStack {
                                Image(enemyImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.15)
                                Image(yourImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.15)
                            }
                            VStack {
                                Image("opponentText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.04)
                                Spacer()
                                Image("youText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.04)
                            }
                            .padding(.vertical)
                        }
                    )
                HStack {
                    ForEach(0..<rpsArray.count, id: \.self) { index in
                        ZStack {
                            Image("rpsChoseFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.15)
                            Image(rpsArray[index])
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.12)
                        }
                        .onTapGesture {
                            if sound {
                                SoundManager.instance.playSound(sound: soundsArray.randomElement() ?? "xoSound1")
                            }
                            makeYourChoise(index: index)
                        }
                    }
                }
            }
        }
            .onAppear {
                shipWobling()
            }
        
    }
    
    func makeYourChoise(index: Int) {
        yourImage = rpsArray[index]
        repeat {
            enemyImage = rpsArray.randomElement() ?? "rock"
        }
        while enemyImage == yourImage
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            checkWinner()
        }
    }
    
    func shipWobling() {
        withAnimation(Animation.easeInOut(duration: 12).repeatForever(autoreverses: true)) {
            shipAngleRotation = -4
        }
    }
    
    func checkWinner() {
        switch yourImage {
        case "rock" :
            if enemyImage == "paper" {
                gameStage = 10
            } else {
                gameStage = 9
            }
        case "paper" :
            if enemyImage == "scissors" {
                gameStage = 10
            } else {
                gameStage = 9
            }
        case "scissors" :
            if enemyImage == "rock" {
                gameStage = 10
            } else {
                gameStage = 9
            }
        default:
            gameStage = 9
        }
    }
    
}

#Preview {
    RPS(gameStage: .constant(7))
}
