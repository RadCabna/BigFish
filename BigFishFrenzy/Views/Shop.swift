//
//  Shop.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var alreadyBoughtItemsArray = UserDefaults.standard.array(forKey: "alreadyBoughtItemsArray") as? [[Int]] ?? Arrays.defaultShopItemsData
    @State private var selectedShopItemsArray = UserDefaults.standard.array(forKey: "defaultShopItemsData") as? [Int] ?? [0,0,0]
    @State private var shopItemsArray = Arrays.shopItemsArray
    @State private var shopItemsCost = Arrays.shopItemsCost
    @State private var shopPack = 0
    @State private var shopItemsOffset: CGFloat = 0
    var body: some View {
        ZStack {
            Background(isLoadingBG: true)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    coordinator.navigateBack()
                }
            Text("SHOP")
                .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.07))
                .foregroundColor(.textcolor)
                .shadow(color: .textshadow, radius: 2)
                .shadow(color: .textshadow, radius: 2)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
//                .onTapGesture {
//                    UserDefaults.standard.removeObject(forKey: "alreadyBoughtItemsArray")
//                    UserDefaults.standard.removeObject(forKey: "defaultShopItemsData")
//                    coinCount = 0
//                    UserDefaults.standard.removeObject(forKey: "defaultShopItemsData")
//                }
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
            HStack {
                ForEach(0...3, id: \.self) { id in
                    if alreadyBoughtItemsArray[shopPack][id] == 0 {
                        VStack {
                            Image(shopItemsArray[shopPack][id])
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: screenWidth*0.2 ,maxHeight: screenHeight*0.35)
                            Image("shopButtonFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.14)
                                .overlay(
                                    ZStack {
                                        Text("BUY")
                                            .font(Font.custom("RammettoOne-Regular", size:screenHeight*0.03))
                                            .foregroundColor(.textcolor)
                                            .shadow(color: .textshadow, radius: 2)
                                            .shadow(color: .textshadow, radius: 2)
                                        HStack {
                                            Image("coin")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.03)
                                            Text("\(shopItemsCost[id])")
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
                        }
                        .onTapGesture {
                            buyShopItem(id: id)
                        }
                    } else if selectedShopItemsArray[shopPack] == id {
                        VStack {
                            Image(shopItemsArray[shopPack][id])
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: screenWidth*0.2 ,maxHeight: screenHeight*0.35)
                            Image("shopButtonFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.14)
                                .overlay(
                                    Text("SELECTED")
                                        .font(Font.custom("RammettoOne-Regular", size:screenHeight*0.03))
                                        .foregroundColor(.textcolor)
                                        .shadow(color: .textshadow, radius: 2)
                                        .shadow(color: .textshadow, radius: 2)
                                )
                        }
                    } else {
                        VStack {
                            Image(shopItemsArray[shopPack][id])
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: screenWidth*0.2 ,maxHeight: screenHeight*0.35)
                            Image("shopButtonFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.14)
                                .overlay(
                                    Text("SELECT")
                                        .font(Font.custom("RammettoOne-Regular", size:screenHeight*0.03))
                                        .foregroundColor(.textcolor)
                                        .shadow(color: .textshadow, radius: 2)
                                        .shadow(color: .textshadow, radius: 2)
                                )
                        }
                        .onTapGesture {
                            selectShopItem(id: id)
                        }
                    }
                }
            }
            .offset(x: shopItemsOffset)
            HStack {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        changeShopPack(direction: -1)
                    }
                Spacer()
                Image("arrowRight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        changeShopPack(direction: 1)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
    
    
    func changeShopPack(direction: Int) {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            shopItemsOffset = CGFloat(direction)*screenWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            shopPack += direction
            if shopPack == 3 {
                shopPack = 0
            }
            if shopPack == -1 {
                shopPack = 2
            }
            shopItemsOffset = -CGFloat(direction)*screenWidth
            withAnimation(Animation.easeInOut(duration: 0.3)) {
                shopItemsOffset = 0
            }
        }
    }
    
    func selectShopItem(id: Int) {
        selectedShopItemsArray[shopPack] = id
        UserDefaults.standard.setValue(selectedShopItemsArray, forKey: "selectedShopItemsArray")
    }
    
    func buyShopItem(id: Int) {
        if coinCount >= shopItemsCost[id] {
            coinCount -= shopItemsCost[id]
            alreadyBoughtItemsArray[shopPack][id] = 1
            UserDefaults.standard.setValue(alreadyBoughtItemsArray, forKey: "alreadyBoughtItemsArray")
        }
    }
    
}

#Preview {
    Shop()
}
