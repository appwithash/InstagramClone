//
//  TabContainerView.swift
//  InstagramClone
//
//  Created by ashutosh on 07/04/21.
//

import SwiftUI

struct TabContainerView: View {
    @AppStorage("currentUser") var currentEmail = ""
 
    @EnvironmentObject var currentUser : User
    @Binding var selectedIndex: Int
    @State var viewState = CGSize.zero
    var body: some View {
        CustomTabBar(selectedIndex: $selectedIndex)
            .environmentObject(currentUser)
            .overlay( LoadingScreen().opacity(self.currentUser.isLoading ? 1 : 0).ignoresSafeArea())
            .onAppear{
             //   print(self.currentEmail)
                currentUser.setUserDetails( email: self.currentEmail)
        }
           
    }
}

struct CustomTabBar : View{
    @Binding var selectedIndex: Int
    @State var shouldShowModal : Bool = false
    var body: some View{
        VStack(spacing:0){
            NavigationView{
            switch selectedIndex{
            case 0:HomeScreenView()
            case 1 : SearchScreenView()
            case 2 :ReelsView()
            case 3:NotificationView()
            case 4:ProfileView()
            default : SearchScreenView()
            }
            }.navigationBarHidden(true)
            Divider()
            HStack{
                Button(action: {
                    selectedIndex = 0
                }, label: {
                    Image(systemName: selectedIndex==0 ? "house.fill" : "house")
                        .font(.system(size: 22))
                        .foregroundColor(selectedIndex==0 ? .black : .gray)
                      
                    
                })
                Spacer()
                Button(action: {
                    selectedIndex = 1
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22))
                        .foregroundColor(selectedIndex==1 ? .black : .gray)
                     
                })
                Spacer()
                Button(action: {
                    selectedIndex = 0
                }, label: {
                    ZStack{
            
                        RoundedRectangle(cornerRadius: Screen.maxWidth*0.02)
                            .stroke(lineWidth: 2)
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                        VStack(spacing:1){
                            ZStack{
                            Capsule()
                                .frame(width: Screen.maxWidth*0.065, height: 3, alignment: .center)
                                .padding(.bottom,2)
                                HStack{
                                    Capsule()
                                        .frame(width: 8, height: 3, alignment: .center)
                                        .rotationEffect(.degrees(45))
                                        .offset(x:4)
                                    Capsule()
                                        .frame(width: 8, height: 3, alignment: .center)
                                        .rotationEffect(.degrees(45))
                                        .offset(x:-2)
                                }.offset(y:-4)
                            }
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 9, height: 9, alignment: .center)
                            .offset(y:-1)
                        }
                    }
                    .accentColor(self.selectedIndex==2  ? Color.black : Color.gray)
                    .onTapGesture {
                        self.selectedIndex=2
                    }
                })

                Spacer()
                Button(action: {
                    selectedIndex = 3
                }, label: {
                    Image(systemName: selectedIndex==3 ? "heart.fill" : "heart")
                        .font(.system(size: 22))
                        .foregroundColor(selectedIndex==3 ? .black : .gray)
                       
                })
                Spacer()
                Button(action: {
                    selectedIndex = 4
                }, label: {
                    Image(systemName: selectedIndex==4 ? "person.fill" : "person")
                        .font(.system(size: 22))
                        .foregroundColor(selectedIndex==4 ? .black : .gray)
                       
                })
                
            }
            .frame(height: Screen.maxHeight*0.025, alignment: .center)
            .shadow(radius: 10)
            .padding()
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            .cornerRadius(20)
          
        
        } .background(Color.white)
          
    }
}



struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView(selectedIndex: .constant(0))
    }
}
