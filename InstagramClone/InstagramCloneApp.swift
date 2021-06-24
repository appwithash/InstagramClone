//
//  InstagramCloneApp.swift
//  InstagramClone
//
//  Created by ashutosh on 05/04/21.
//

import SwiftUI
import Firebase
@main
struct InstagramCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var currentUser = User()
    var body: some Scene {
        WindowGroup {
            if currentUser.status{
            TabContainerView().environmentObject(currentUser)
            }else{
                LoginScreenView().environmentObject(currentUser)
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
