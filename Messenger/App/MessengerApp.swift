//
//  MessengerApp.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 26.10.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        print("Firebase Connceted")
        print("Firebase Connceted")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
