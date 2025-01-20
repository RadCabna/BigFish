//
//  Coordinator.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 20.01.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
//    case first
//    case second
    case loading
//    case mainMenu
//    case settings
//    case howToPlay
//    case yourCivilization
//    case otherCivilization
    
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []

    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
//        case .mainMenu:
//            view = AnyView(MainMenu())
//        case .settings:
//            view = AnyView(Settings())
//        case .howToPlay:
//            view = AnyView(HowToPlayView())
//        case .yourCivilization:
//            view = AnyView(YourCivilizationView())
//        case .otherCivilization:
//            view = AnyView(OtherCivilizationView())
//        case .first:
//            view = AnyView(FirstView())
//        case .second:
//            view = AnyView(SecondView())
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

