//
//  Madel.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 21.01.2025.
//

import Foundation
import SwiftUI

struct Guide: Equatable, Hashable {
    
    var guideImage: String
    var guideText: String
}

struct ShopItems {
    var itemName: String
}

class Arrays {
    
    static let shopItemsCost = [1, 200, 500, 3500]
    
    static let shopItemsArray = [
    ["ship1","ship2","ship3","ship4"],
    ["hook1","hook2","hook3","hook4"],
    ["rod1","rod2","rod3","rod4"]
    ]
    
    static let defaultShopItemsData = [
    [1,0,0,0],
    [1,0,0,0],
    [1,0,0,0]
    ]
    
    static var guideArray: [Guide] = [
    Guide(guideImage: "guide1", guideText: "The goal of the game is to catch as many fish as possible, exchange them for coins and use the money to upgrade your equipment."),
    Guide(guideImage: "guide2", guideText: "Invest in better fishing rods and boats to increase efficiency and simplify fishing. Fish are divided into three categories of rarity: common, rare and mythical. "),
    Guide(guideImage: "guide3", guideText: "Expand your collection by catching different types of fish, choosing the largest and most valuable ones. Upgrade your gear, increase your catch, and work your way to becoming the ultimate fishing master!")
    ]
}


