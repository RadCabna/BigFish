//
//  Game.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 22.01.2025.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var selectedShopItemsArray = UserDefaults.standard.array(forKey: "defaultShopItemsData") as? [Int] ?? [0,0,0]
    @State private var shopItemsArray = Arrays.shopItemsArray
    var body: some View {
        ZStack {
            Background(isLoadingBG: false)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top)
            Image(whatShip())
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.4)
                .overlay(
                Image("fisher")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.8)
                    .offset(x:screenWidth*0.15, y: -screenHeight*0.2)
                )
                .offset(x:-screenWidth*0.4, y: screenHeight*0.3)
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
    
    func whatShip() -> String {
        return shopItemsArray[0][3]
    }
    
}

#Preview {
    Game()
}
