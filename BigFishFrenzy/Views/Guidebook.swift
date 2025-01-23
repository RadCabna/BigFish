//
//  Guidebook.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import SwiftUI

struct Guidebook: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var guideArray = Arrays.guideArray
    @State private var guideNumber = 2
    var body: some View {
        ZStack {
            Background(isLoadingBG: true)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top)
                .onTapGesture {
                    coordinator.navigateBack()
                }
            Text("GUIDEBOOK")
                .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.07))
                .foregroundColor(.textcolor)
                .shadow(color: .textshadow, radius: 2)
                .shadow(color: .textshadow, radius: 2)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
            HStack {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        changeGuideAnimation(direction: -1)
                    }
                Spacer()
                Image("arrowRight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        changeGuideAnimation(direction: 1)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            VStack {
                Image("\(guideArray[guideNumber].guideImage)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.4)
                Text("\(guideArray[guideNumber].guideText)")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.035))
                    .foregroundColor(.white)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                    .multilineTextAlignment(.center)
                    .lineSpacing(0)
                    .frame(maxWidth: screenWidth*0.7)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, screenHeight*0.17)
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
    
    func changeGuideAnimation(direction: Int) {
        withAnimation(Animation.easeInOut(duration: 1)) {
            guideNumber += direction
            if guideNumber == 3 {
                guideNumber = 0
            }
            if guideNumber == -1 {
                guideNumber = 2
            }
        }
    }
    
}

#Preview {
    Guidebook()
}
