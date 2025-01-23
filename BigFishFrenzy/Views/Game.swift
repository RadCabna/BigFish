//
//  Game.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 22.01.2025.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") private var sound = true
    @AppStorage("vibration") private var vibration = true
    @AppStorage("coinCount") var coinCount = 0
    @State private var selectedShopItemsArray = UserDefaults.standard.array(forKey: "selectedShopItemsArray") as? [Int] ?? [0,0,0]
    @State private var shopItemsArray = Arrays.shopItemsArray
    @State private var floatInTheWater = false
    @State private var floatAngleRotation: CGFloat = 10
    @State private var floatYOffset: CGFloat = 0.5
    @State private var rectangleRotationAngle: CGFloat = 0
    @State private var timer1: Timer?
    @State private var timer2: Timer?
    @State private var gameStage = 0
    @State private var showYourCatch = false
    @State private var canWeTap = true
    let soundArray = ["rollSound1","rollSound2","rollSound3","rollSound4"]
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
            ShipAndFisher(shipNumber: selectedShopItemsArray[0],canWeTap: canWeTap, floatInTheWater: $floatInTheWater)
            
                .onTapGesture {
//                    floatInTheWater.toggle()
                }
            if gameStage == 0 {
                Image("startFishingButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .onTapGesture {
                        withAnimation() {
                            gameStage = 1
                        }
                        if sound {
                            SoundManager.instance.playSound(sound: "dropSound")
                        }
                        floatInTheWater = true
                        startTimer()
                        floatYOffset = 0.5
                    }
            }
            if gameStage == 1 {
                VStack {
                    ZStack {
                        Image("float1")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.3)
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.white)
                            .frame(width: screenWidth*0.02, height: screenHeight*0.1)
                            .offset(y: -screenHeight*0.14)
                            .rotationEffect(Angle(degrees: rectangleRotationAngle))
                    }
                    Image("stopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.15)
                        .onTapGesture {
                            if rectangleRotationAngle >= 90 && rectangleRotationAngle <= 270 {
                                withAnimation() {
                                    gameStage = 2
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: soundArray.randomElement() ?? "rollSound1")
                                }
                            } else {
                                if vibration {
                                    generateImpactFeedback(style: .heavy)
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: "failSound")
                                }
                                stopTimer()
                                withAnimation() {
                                    gameStage = 0
                                }
                                floatInTheWater = false
                                floatYOffset = 0.5
                            }
                        }
                        .padding(.top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom)
                .padding(.trailing)
            }
            if gameStage == 2 {
                VStack {
                    ZStack {
                        Image("float2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.3)
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.white)
                            .frame(width: screenWidth*0.02, height: screenHeight*0.1)
                            .offset(y: -screenHeight*0.14)
                            .rotationEffect(Angle(degrees: rectangleRotationAngle))
                    }
                    Image("stopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.15)
                        .padding(.top)
                        .onTapGesture {
                            if rectangleRotationAngle >= 90 && rectangleRotationAngle <= 180 {
                                withAnimation() {
                                    gameStage = 3
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: soundArray.randomElement() ?? "rollSound1")
                                }
                            } else {
                                if vibration {
                                    generateImpactFeedback(style: .heavy)
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: "failSound")
                                }
                                stopTimer()
                                withAnimation() {
                                    gameStage = 0
                                }
                                floatInTheWater = false
                                floatYOffset = 0.5
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom)
                .padding(.trailing)
                
            }
            if gameStage == 3 {
                VStack {
                    ZStack {
                        Image("float3")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.3)
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.white)
                            .frame(width: screenWidth*0.02, height: screenHeight*0.1)
                            .offset(y: -screenHeight*0.14)
                            .rotationEffect(Angle(degrees: rectangleRotationAngle))
                    }
                    Image("stopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.15)
                        .padding(.top)
                        .onTapGesture {
                            if rectangleRotationAngle >= 45 && rectangleRotationAngle <= 90 {
                                withAnimation() {
                                    gameStage = 4
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: soundArray.randomElement() ?? "rollSound1")
                                }
                                startTimer2()
                                floatWobling()
                            } else {
                                if vibration {
                                    generateImpactFeedback(style: .heavy)
                                }
                                if sound {
                                    SoundManager.instance.playSound(sound: "failSound")
                                }
                                stopTimer()
                                withAnimation() {
                                    gameStage = 0
                                }
                                floatInTheWater = false
                                floatYOffset = 0.5
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom)
                .padding(.trailing)
                
            }
            if gameStage == 4 {
                VStack {
                    ZStack {
                        Image("flask")
                            .resizable()
                            .frame(width: screenWidth*0.07, height: screenHeight*0.6)
                        Image("float")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.25)
                            .rotationEffect(Angle(degrees: floatAngleRotation))
                            .offset(y: -screenHeight*0.25 + floatYOffset*screenHeight*0.4)
                        Rectangle()
                            .frame(width: screenWidth*0.05, height: screenHeight*0.6)
                            .foregroundColor(.blue)
                            .offset(y: floatYOffset*screenHeight*0.4 + screenHeight*0.05)
                            .opacity(0.5)
                            .mask(
                                Image("flask")
                                    .resizable()
                                    .frame(width: screenWidth*0.06, height: screenHeight*0.59)
                            )
                       
                    }
                    Text("PUSH AS FAST AS YOU CAN TO PULL THE FISH OUT")
                        .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.035))
                        .foregroundColor(.textcolor)
                        .shadow(color: .textshadow, radius: 2)
                        .shadow(color: .textshadow, radius: 2)
                        .lineSpacing(0)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: screenWidth*0.2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .onTapGesture {
                    if vibration {
                        generateImpactFeedback(style: .light)
                    }
                    withAnimation() {
                        floatYOffset -= 0.02
                    }
                }
            }
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
            floatWobling()
//            startTimer2()
        }
        .onChange(of: floatYOffset) { _ in
            if floatYOffset <= 0 {
                stopTimer2()
                showYourCatch = true
            } else if floatYOffset >= 1.2 {
                if vibration {
                    generateImpactFeedback(style: .heavy)
                }
                if sound {
                    SoundManager.instance.playSound(sound: "failSound")
                }
                stopTimer()
                stopTimer2()
                floatYOffset = 0.5
                gameStage = 0
                floatInTheWater = false
            }
        }
        .onChange(of: showYourCatch) { _ in
            if !showYourCatch {
                stopTimer()
                stopTimer2()
                floatYOffset = 0.5
                gameStage = 0
                floatInTheWater = false
            }
        }
        .fullScreenCover(isPresented: $showYourCatch) {
            CatchView(showYourCatch: $showYourCatch)
        }
    }
    
    func floatWobling() {
        floatAngleRotation = 10
        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            floatAngleRotation = -10
        }
    }
    
    func whatShip() -> String {
        return shopItemsArray[0][3]
    }
    
    func generateImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        if vibration {
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    func startTimer() {
        timer1 = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            rectangleRotationAngle += 5
            if rectangleRotationAngle == 360 {
                rectangleRotationAngle = 0
            }
        }
    }
    
    func stopTimer() {
        timer1?.invalidate()
        timer1 = nil
    }
    func startTimer2() {
        timer2 = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            withAnimation() {
                floatYOffset += 0.02
            }
        }
    }
    
    func stopTimer2() {
        timer2?.invalidate()
        timer2 = nil
    }
    
}

#Preview {
    Game()
}
