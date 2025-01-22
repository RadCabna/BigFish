//
//  Coordinator.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 20.01.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case main
    case settings
    case guidebook
    case shop
    case game
    case trophy
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []

    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .main:
            view = AnyView(Menu())
        case .settings:
            view = AnyView(Settings())
        case .guidebook:
            view = AnyView(Guidebook())
        case .shop:
            view = AnyView(Shop())
        case .game:
            view = AnyView(Game())
        case .trophy:
            view = AnyView(TrophyRoom())
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}

