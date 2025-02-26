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

struct TicTacItem: Equatable {
    var name: String
    var active = false
    var yourItem = false
}

struct Fish {
    var fishName: String
    var description: String
    var rarity: String
    var weight: Double
}

class Arrays {
    
    static var ticTacArray: [[TicTacItem]] = [
    [TicTacItem(name: "50cage"),TicTacItem(name: "50cage"),TicTacItem(name: "50cage")],
    [TicTacItem(name: "50cage"),TicTacItem(name: "50cage"),TicTacItem(name: "50cage")],
    [TicTacItem(name: "50cage"),TicTacItem(name: "50cage"),TicTacItem(name: "50cage")]
    ]
    
    static var chanceToCatchAFish = [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,5,5,5,5,6,6,6,7,7,8]
    
    static let fishArray: [Fish] = [
        Fish(fishName: "Pebblefish", description: "A fish with grayish, pebble-like scales that blends perfectly with rocky riverbeds. Known for its calm demeanor.", rarity: "Common", weight: .random(in: 1...3)),
        Fish(fishName: "Amberfin", description: "A golden-yellow fish often found in sunlit waters. Its fins sparkle faintly in bright light.", rarity: "Common", weight: .random(in: 1...2.5)),
        Fish(fishName: "Ripplecarp", description: "A round fish with delicate patterns on its scales resembling ripples on water. Prefers slow-moving streams.", rarity: "Common", weight: .random(in: 2...4)),
        Fish(fishName: "Starstripe", description: "A fish with silver stripes on a dark body that shimmer like stars in the night. Found in twilight waters.", rarity: "Rare", weight: .random(in: 4...8)),
        Fish(fishName: "Frosttail", description: "A fish with icy-blue scales and a frosty-white tail, often seen in cooler regions or near glacial waters.", rarity: "Rare", weight: .random(in: 3...6)),
        Fish(fishName: "Copperhead Pike", description: "A sleek fish with a coppery sheen on its head and body, known for its speed and agility. Found in clear rivers.", rarity: "Rare", weight: .random(in: 5...9)),
        Fish(fishName: "Golden Leviathan", description: "A legendary fish with radiant golden scales that glow underwater. Said to bring prosperity to its captor.", rarity: "Mythical", weight: .random(in: 25...50)),
        Fish(fishName: "Eclipse Ray", description: "A large, flat fish with a pattern resembling an eclipse on its back. Rarely seen, it emerges only during lunar eclipses.", rarity: "Mythical", weight: .random(in: 20...40)),
        Fish(fishName: "Stormcaller Marlin", description: "A massive marlin with silver-blue scales that spark during storms. Fishermen say it controls the weather.", rarity: "Mythical", weight: .random(in: 30...60))
    ]
    
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


