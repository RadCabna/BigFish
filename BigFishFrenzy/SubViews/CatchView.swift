//
//  CatchView.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 22.01.2025.
//

import SwiftUI

struct CatchView: View {
    @AppStorage("sound") private var sound = true
    @EnvironmentObject var coordinator: Coordinator
    @State private var fishArray = Arrays.fishArray
    @State private var catchFishArray = UserDefaults.standard.array(forKey: "catchFishArray") as? [[String]] ?? []
    @State private var catchFishData: [String] = []
    @State private var chance = Arrays.chanceToCatchAFish
    @State private var fishNumber = 0
    @Binding var showYourCatch: Bool
    var body: some View {
        ZStack {
            Background(isLoadingBG: false).blur(radius: 5).scaleEffect(x: 1.1, y:1.1).ignoresSafeArea()
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    createCatchFishArray()
                    coordinator.navigate(to: .main)
                }
            Image("nextButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.13)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom)
                .onTapGesture {
                    createCatchFishArray()
                    showYourCatch.toggle()
                }
            VStack {
                Text("THE FISH WERE SUCCESFSULLY CAUGHT!")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.05))
                    .foregroundColor(.textcolor)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                    .frame(maxWidth: screenWidth*0.5)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("\(fishArray[fishNumber].fishName)")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.07))
                    .foregroundColor(.textcolor2)
                    .shadow(color: .textcolor, radius: 2)
                    .shadow(color: .textcolor, radius: 2)
                Text("\(fishArray[fishNumber].description)")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.05))
                    .foregroundColor(.white)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: screenWidth*0.7)
                Spacer()
                HStack {
                    Image("weightFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.23)
                        .overlay(
                            VStack {
                                Text("PARITY")
                                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.04))
                                    .foregroundColor(.textshadow)
                                    .shadow(color: .textcolor, radius: 2)
                                    .shadow(color: .textcolor, radius: 2)
                                Text("\(fishArray[fishNumber].rarity)")
                                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.03))
                                    .foregroundColor(.textcolor)
                                    .shadow(color: .textshadow, radius: 2)
                                    .shadow(color: .textshadow, radius: 2)
                                    .frame(maxWidth: screenWidth*0.5)
                            }
                        )
                    Image("weightFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.23)
                        .overlay(
                            VStack {
                                Text("WEIGHT")
                                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.04))
                                    .foregroundColor(.textshadow)
                                    .shadow(color: .textcolor, radius: 2)
                                    .shadow(color: .textcolor, radius: 2)
                                Text("\(fishArray[fishNumber].weight, specifier: "%.1f") KG")
                                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.03))
                                    .foregroundColor(.textcolor)
                                    .shadow(color: .textshadow, radius: 2)
                                    .shadow(color: .textshadow, radius: 2)
                                    .frame(maxWidth: screenWidth*0.5)
                            }
                        )
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
            whatFishYouCatch()
            if sound {
                SoundManager.instance.playSound(sound: "levelDone")
            }
        }
    }
    
    func createCatchFishArray() {
        catchFishData.append(fishArray[fishNumber].fishName)
        catchFishData.append(String(format: "%.1f",(fishArray[fishNumber].weight)))
        catchFishData.append(String(fishNumber + 1))
        catchFishData.append(fishArray[fishNumber].description)
        catchFishArray.append(catchFishData)
        UserDefaults.standard.setValue(catchFishArray, forKey: "catchFishArray")
    }
    
    func whatFishYouCatch() {
        fishNumber = chance.randomElement() ?? 0
    }
    
}

#Preview {
    CatchView(showYourCatch: .constant(true))
}
