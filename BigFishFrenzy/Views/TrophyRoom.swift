//
//  TrophyRoom.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 22.01.2025.
//

import SwiftUI

struct TrophyRoom: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("sound") private var sound = true
    @State private var catchFishArray = UserDefaults.standard.array(forKey: "catchFishArray") as? [[String]] ?? []
    @State private var trophyNumber = 0
    @State private var trophyOffset: CGFloat = 0
    var body: some View {
        ZStack {
            Background(isLoadingBG: true)
            VStack {
                Text("TROPHY ROOM")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.05))
                    .foregroundColor(.textcolor)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                    .frame(maxWidth: screenWidth*0.5)
                Spacer()
                if !catchFishArray.isEmpty {
                    Text(catchFishArray[trophyNumber][0])
                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.07))
                        .foregroundColor(.textcolor2)
                        .shadow(color: .textcolor, radius: 2)
                        .shadow(color: .textcolor, radius: 2)
                    HStack {
                        Image("weightFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.25)
                            .overlay(
                                VStack {
                                    Text("WEIGHT")
                                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.04))
                                        .foregroundColor(.textshadow)
                                        .shadow(color: .textcolor, radius: 2)
                                        .shadow(color: .textcolor, radius: 2)
                                    Text("\(catchFishArray[trophyNumber][1]) KG")
                                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.03))
                                        .foregroundColor(.textcolor)
                                        .shadow(color: .textshadow, radius: 2)
                                        .shadow(color: .textshadow, radius: 2)
                                        .frame(maxWidth: screenWidth*0.5)
                                }
                            )
                        Image("fish" + catchFishArray[trophyNumber][2])
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.4)
                        Image("shopButtonFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.14)
                            .overlay(
                                ZStack {
                                    Text("SELL")
                                        .font(Font.custom("RammettoOne-Regular", size:screenHeight*0.035))
                                        .foregroundColor(.textcolor)
                                        .shadow(color: .textshadow, radius: 2)
                                        .shadow(color: .textshadow, radius: 2)
                                    HStack {
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.03)
                                        Text("\(2*Int(Double(catchFishArray[trophyNumber][1]) ?? 10))")
                                            .font(Font.custom("RammettoOne-Regular", size:screenHeight*0.03))
                                            .foregroundColor(.textcolor)
                                            .shadow(color: .textshadow, radius: 2)
                                            .shadow(color: .textshadow, radius: 2)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .bottomTrailing)
                                    .padding(.trailing, screenWidth*0.01)
                                    .padding(.bottom, screenHeight*0.015)
                                }
                            )
                            .onTapGesture {
                                sellTrophy()
                            }
                    }
                    Spacer()
                    Text(catchFishArray[trophyNumber][3])
                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.045))
                        .foregroundColor(.white)
                        .shadow(color: .textshadow, radius: 2)
                        .shadow(color: .textshadow, radius: 2)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: screenWidth*0.6)
                } else {
                    
                    Text("The fish you caught will appear here.")
                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.05))
                        .foregroundColor(.textcolor)
                        .shadow(color: .textshadow, radius: 2)
                        .shadow(color: .textshadow, radius: 2)
                        .frame(maxWidth: screenWidth*0.5)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .padding(.vertical)
            .offset(x: trophyOffset)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    coordinator.navigateBack()
                }
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top)
                .onTapGesture {
                    UserDefaults.standard.removeObject(forKey: "catchFishArray")
                }
            if catchFishArray.count > 1 {
                HStack {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                       changeTrophyAnimation(direction: -1)
                    }
                Spacer()
                Image("arrowRight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        changeTrophyAnimation(direction: 1)
                    }
            }
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
    
    func sellTrophy() {
        coinCount += 2*Int(Double(catchFishArray[trophyNumber][1]) ?? 10)
        catchFishArray.remove(at: trophyNumber)
        UserDefaults.standard.setValue(catchFishArray, forKey: "catchFishArray")
        trophyNumber = catchFishArray.count - 1
        if sound {
            SoundManager.instance.playSound(sound: "buySound")
        }
    }
    
    func changeTrophyAnimation(direction: Int) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            trophyOffset = Double(direction)*screenWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            trophyNumber += direction
            if trophyNumber > catchFishArray.count-1 {
                trophyNumber = 0
            }
            if trophyNumber < 0 {
                trophyNumber = catchFishArray.count - 1
            }
            trophyOffset = -Double(direction)*screenWidth
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                trophyOffset = 0
            }
        }
    }
    
}

#Preview {
    TrophyRoom()
}
