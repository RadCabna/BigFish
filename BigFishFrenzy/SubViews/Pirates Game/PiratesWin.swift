//
//  PiratesWin.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct PiratesWin: View {
    @AppStorage("sound") private var sound = true
    @EnvironmentObject var coordinator: Coordinator
    @State private var catchFishArray = UserDefaults.standard.array(forKey: "catchFishArray") as? [[String]] ?? []
    @AppStorage("coinCount") var coinCount = 0
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
                    robbery()
                    coordinator.navigate(to: .main)
                }
            VStack {
                Image("loseText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.35)
                Spacer()
                Image("continueFishingButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        robbery()
                        gameStage = 0
                    }
            }
            .padding(.vertical)
        }
        
        .onAppear {
            if sound {
                SoundManager.instance.playSound(sound: "piratesWinSound")
            }
        }
        
    }
    
    func robbery() {
        if !catchFishArray.isEmpty {
            catchFishArray.removeLast()
        }
        if coinCount > 0 {
            coinCount -= Int(Double(coinCount)*0.1)
        }
    }
    
}

#Preview {
    PiratesWin(gameStage: .constant(10))
}
