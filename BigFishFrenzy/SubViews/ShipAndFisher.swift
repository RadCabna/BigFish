//
//  ShipAndFisher.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 22.01.2025.
//

import SwiftUI

struct ShipAndFisher: View {
    var shipNumber = 0
    var canWeTap = false
    @Binding var floatInTheWater: Bool
    @State private var lineScale: CGFloat = 1
    @State private var lineOffset: CGFloat = 0
    @State private var shipAngleRotation: CGFloat = 4
    var body: some View {
        switch shipNumber {
        case 1:
            ZStack {
                Image("ship2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight)
                    .offset(y:-screenHeight*0.1)
                    .onTapGesture {
                        floatInTheWater.toggle()
                    }
                Image("fisher")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.45)
                    .offset(x:screenWidth*0.12, y: -screenHeight*0.065)
                Image("hookAndLine")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.54)
                    .offset(x:screenWidth*0.184, y: -screenHeight*0.16 + screenHeight*lineOffset)
                    .scaleEffect(x: 1, y: lineScale*0.5)
                    .offset(y: -screenHeight*0.07)
            }
            .rotationEffect(Angle(degrees: shipAngleRotation))
            .offset(x: -screenWidth*0.4, y: screenHeight*0.36)
            .onChange(of: floatInTheWater) { _ in
                if canWeTap {
                    lineAnimation()
                }
            }
            .onAppear {
                shipWobling()
            }
        case 2:
            ZStack {
                Image("ship3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight)
                    .offset(x: -screenWidth*0.1, y:screenHeight*0.1)
                    .onTapGesture {
                        floatInTheWater.toggle()
                    }
                Image("fisher1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.33)
                    .offset(x:screenWidth*0.12, y: -screenHeight*0.12)
                Image("hookAndLine")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.54)
                    .offset(x:screenWidth*0.184, y: -screenHeight*0.16 + screenHeight*lineOffset)
                    .scaleEffect(x: 1, y: lineScale*0.5)
                    .offset(y: -screenHeight*0.07)
            }
            .rotationEffect(Angle(degrees: shipAngleRotation))
            .offset(x: -screenWidth*0.4, y: screenHeight*0.36)
            .onChange(of: floatInTheWater) { _ in
                if canWeTap {
                    lineAnimation()
                }
            }
            .onAppear {
                shipWobling()
            }
        case 3:
            ZStack {
                Image("ship4")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight)
                    .offset(x: -screenWidth*0.05, y:-screenHeight*0.1)
                    .onTapGesture {
                        floatInTheWater.toggle()
                    }
                Image("fisher1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.33)
                    .offset(x:screenWidth*0.12, y: -screenHeight*0.12)
                Image("hookAndLine")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.54)
                    .offset(x:screenWidth*0.184, y: -screenHeight*0.16 + screenHeight*lineOffset)
                    .scaleEffect(x: 1, y: lineScale*0.5)
                    .offset(y: -screenHeight*0.07)
            }
            .rotationEffect(Angle(degrees: shipAngleRotation))
            .offset(x: -screenWidth*0.4, y: screenHeight*0.36)
            .onChange(of: floatInTheWater) { _ in
                if canWeTap {
                    lineAnimation()
                }
            }
            .onAppear {
                shipWobling()
            }
        default:
            ZStack {
                Image("ship1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.5)
                    .onTapGesture {
                        floatInTheWater.toggle()
                    }
                Image("fisher1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.45)
                    .offset(x:screenWidth*0.1, y: -screenHeight*0.22)
                Image("hookAndLine")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.54)
                    .offset(x:screenWidth*0.184, y: -screenHeight*0.16 + screenHeight*lineOffset)
                    .scaleEffect(y: lineScale)
            }
            .rotationEffect(Angle(degrees: shipAngleRotation))
            .offset(x: -screenWidth*0.4, y: screenHeight*0.3)
            .onChange(of: floatInTheWater) { _ in
                if canWeTap {
                    lineAnimation()
                }
            }
            .onAppear {
                shipWobling()
                AppDelegate().setOrientation(to: .landscapeLeft)
            }
        }
    }
    
    
    func lineAnimation() {
        if floatInTheWater {
            withAnimation(Animation.easeInOut(duration: 0.1)) {
                lineOffset = 0.214
            }
            withAnimation(Animation.easeInOut(duration: 0.117)) {
                lineScale = 2
            }
        } else {
            lineOffset = 0
            lineScale = 1
        }
    }
    
    func shipWobling() {
        withAnimation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
            shipAngleRotation = -4
        }
    }
    
}

#Preview {
    ShipAndFisher(floatInTheWater: .constant(false))
}
