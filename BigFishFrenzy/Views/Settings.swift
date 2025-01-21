//
//  Settings.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("music") private var music = true
    @AppStorage("sound") private var sound = true
    @AppStorage("vibration") private var vibration = true
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
            VStack(spacing: screenHeight*0.02) {
                Text("SETTINGS")
                    .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.07))
                    .foregroundColor(.textcolor)
                    .shadow(color: .textshadow, radius: 2)
                    .shadow(color: .textshadow, radius: 2)
                Image("settingsFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .overlay(
                        HStack {
                            Text("MUSIC")
                                .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.06))
                                .foregroundColor(.textcolor)
                                .shadow(color: .textshadow, radius: 2)
                                .shadow(color: .textshadow, radius: 2)
                            Spacer()
                            Toggle("", isOn: $music)
                                .toggleStyle(CustomToggle())
                        }
                            .padding(.horizontal)
                    )
                Image("settingsFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .overlay(
                        HStack {
                            Text("SOUND")
                                .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.06))
                                .foregroundColor(.textcolor)
                                .shadow(color: .textshadow, radius: 2)
                                .shadow(color: .textshadow, radius: 2)
                            Spacer()
                            Toggle("", isOn: $sound)
                                .toggleStyle(CustomToggle())
                        }
                            .padding(.horizontal)
                    )
                Image("settingsFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .overlay(
                        HStack {
                            Text("VIBR")
                                .font(Font.custom("RammettoOne-Regular", size: screenHeight*0.06))
                                .foregroundColor(.textcolor)
                                .shadow(color: .textshadow, radius: 2)
                                .shadow(color: .textshadow, radius: 2)
                            Spacer()
                            Toggle("", isOn: $vibration)
                                .toggleStyle(CustomToggle())
                        }
                            .padding(.horizontal)
                    )
                Image("rateUsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.2)
                    .onTapGesture {
                        openAppStoreForRating()
                    }
            }
        }
        .onAppear {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
    }
    
    func openAppStoreForRating() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id7777777777?action=write-review") else {
            return
        }
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
}

#Preview {
    Settings()
}

struct CustomToggle: ToggleStyle {
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: screenHeight*0.04)
                    .fill(Color.colorotoggle)
                    .frame(width: screenHeight*0.15, height: screenHeight*0.06)
            }
            .opacity(configuration.isOn ? 1 : 0.3)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: screenHeight*0.03)
                        .frame(width: screenHeight*0.07, height: screenHeight*0.03)
                        .foregroundColor(.white)
                        .shadow(radius: 1, y: 0)
                        .offset(x: configuration.isOn ? screenHeight*0.025 : -screenHeight*0.025)
                        .animation(.easeInOut, value: configuration.isOn)
                   
                   
                }
            )
        }
    }
}
