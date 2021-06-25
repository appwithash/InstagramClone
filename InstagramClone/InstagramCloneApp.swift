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
    @State var selectedIndex: Int = 0
    @State var isCamera = false
    @State var viewState = CGSize.zero
    var body: some Scene {
        WindowGroup {
            if currentUser.status{

                ZStack{
                   
                    CameraView().environmentObject(currentUser).opacity(isCamera ? 1 : 0).animation(.default)
                        .animation(.default)
                        .highPriorityGesture(
                            DragGesture()
                                .onChanged{ value in
                            withAnimation {
                                print(value.translation)
                               
                                    self.viewState.width = 414 - value.translation.width
                                    print(value.translation)
                                print("view state = ",value.translation)
                                    self.isCamera=true
                             
                            }
                        }
                                    .onEnded { value in
                            withAnimation {
                                if value.translation.width < Screen.maxWidth/2 {
                                    self.viewState.width = .zero
                                    self.isCamera=true
                                }
                                print(value.translation.width)
                            
                            }
                        })
                     
                    TabContainerView(selectedIndex: $selectedIndex).ignoresSafeArea(.all).environmentObject(currentUser).background(Color.white)
                        .offset(x: viewState.width)
                        .animation(.default)
                        .highPriorityGesture(
                           selectedIndex==0 ?
                            DragGesture()
                                .onChanged{ value in
                                        withAnimation {
                                            if value.translation.width > 0 {
                                                self.viewState.width = value.translation.width
                                                self.isCamera=true
                                            } else {
                                                self.isCamera=false
                                                self.viewState = .zero
                                            }
                                        }
                            }
                            .onEnded { value in
                                withAnimation {
                                    if value.translation.width > Screen.maxWidth/2 {
                                            self.viewState.width = Screen.maxWidth
                                            self.isCamera=true
                                            } else {
                                                self.isCamera=false
                                                self.viewState = .zero
                                            }
                                    }
                                    }
                           : DragGesture().onChanged({ value in})
                            .onEnded({ value in })
                        )
                }
                      
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
