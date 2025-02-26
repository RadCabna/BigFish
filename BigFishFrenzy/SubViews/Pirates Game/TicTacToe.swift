//
//  TicTacToe.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 26.02.2025.
//

import SwiftUI

struct TicTacToe: View {
    @AppStorage("sound") private var sound = true
    @State private var ticTacArray = Arrays.ticTacArray
    @State private var yourStep = true
    @State private var youWin = false
    @State private var youLose = false
    @State private var whoWin = "none"
    @State private var shipAngleRotation: CGFloat = 4
    @Binding var gameStage: Int
    var soundsArray = ["xoSound1", "xoSound2", "xoSound3"]
    var body: some View {
        ZStack {
            VStack( spacing: 0) {
                ForEach(0..<ticTacArray.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<ticTacArray[row].count, id: \.self) { col in
                            ZStack {
                                Image("50cage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.18)
                                if ticTacArray[row][col].active {
                                    Image(ticTacArray[row][col].name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.14)
                                }
                            }
                            .onTapGesture {
                                makeYourStep(row: row, col: col)
                            }
                        }
                    }
                }
            }
            Image("piratesShip")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .rotationEffect(Angle(degrees: shipAngleRotation))
                .offset(x: screenHeight*0.6)
            
            if yourStep {
                Image("yourTurnText")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                    .padding(.top)
                    .offset(y: screenHeight*0.34)
            }
        }
        
        .onAppear {
            shipWobling()
        }
        
        .onChange(of: youWin) { _ in
            if youWin {
                gameStage = 9
            }
        }
        
        .onChange(of: youLose) { _ in
            if youLose {
                gameStage = 10
            }
        }
        
        .onChange(of: whoWin) { _ in
            if whoWin == "first" {
                youWin = true
            }
            if whoWin == "second" {
                youLose = true
            }
        }
        
    }
    
    func shipWobling() {
        withAnimation(Animation.easeInOut(duration: 12).repeatForever(autoreverses: true)) {
            shipAngleRotation = -4
        }
    }
    
//    func checkGamePlate() {
//        for i in 0..<ticTacArray.count {
//            for j in 0..<ticTacArray[i].count {
//                
//            }
//        }
//    }
    
    func makeYourStep(row: Int, col: Int) {
        if yourStep && !ticTacArray[row][col].active {
            if sound {
                SoundManager.instance.playSound(sound: soundsArray.randomElement() ?? "xoSound1")
            }
            ticTacArray[row][col].active = true
            ticTacArray[row][col].yourItem = true
            ticTacArray[row][col].name = "x"
            checkForWin(name: "x", winner: "first")
            if !youWin && !youLose {
                yourStep.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    makeEnemyStep()
                }
            }
        }
    }
    
    func makeEnemyStep() {
        var emptyCagesArray: [(row: Int, col: Int)] = []
        for i in 0..<ticTacArray.count {
            for j in 0..<ticTacArray[i].count {
                if ticTacArray[i][j].name == "50cage" {
                    emptyCagesArray.append((i,j))
                }
            }
        }
        if !yourStep {
            if sound {
                SoundManager.instance.playSound(sound: soundsArray.randomElement() ?? "xoSound1")
            }
            if !youWin && !youLose {
                let randomeCoordinates = emptyCagesArray.randomElement() ?? (0,0)
                ticTacArray[randomeCoordinates.row][randomeCoordinates.col].active = true
                ticTacArray[randomeCoordinates.row][randomeCoordinates.col].yourItem = false
                ticTacArray[randomeCoordinates.row][randomeCoordinates.col].yourItem = false
                ticTacArray[randomeCoordinates.row][randomeCoordinates.col].name = "o"
                checkForWin(name: "o", winner: "second")
            }
            if !youWin && !youLose {
                yourStep.toggle()
            }
        }
    }
    
    func checkForWin(name: String?, winner: String) {
            for row in 0..<3 {
                if let first = name, first == ticTacArray[row][0].name, first == ticTacArray[row][1].name, first == ticTacArray[row][2].name {
                    whoWin = winner
                    return
                }
            }
            
            for column in 0..<3 {
                if let first = name, first == ticTacArray[1][column].name, first == ticTacArray[2][column].name, first == ticTacArray[0][column].name {
                    whoWin = winner
                    return
                }
            }
            
        if let first = name, first == ticTacArray[0][0].name, first == ticTacArray[1][1].name, first == ticTacArray[2][2].name {
            whoWin = winner
                return
            }
            
        if let first = name, first == ticTacArray[0][2].name, first == ticTacArray[1][1].name, first == ticTacArray[2][0].name {
            whoWin = winner
                return
            }
        
        if !ticTacArray.flatMap({ $0 }).contains(where: {$0.name == "50cage"}) {
            gameStage = 9
        }
        
        }
}

#Preview {
    TicTacToe(gameStage: .constant(6))
}
