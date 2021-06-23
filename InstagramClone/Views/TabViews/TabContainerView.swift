//
//  TabContainerView.swift
//  InstagramClone
//
//  Created by ashutosh on 07/04/21.
//

import SwiftUI

struct TabContainerView: View {
    var body: some View {
        CustomTabBar()
    }
}

struct CustomTabBar : View{
    @State var selectedIndex: Int = 0
    @State var shouldShowModal : Bool = false
    var body: some View{
        VStack(spacing:0){
            NavigationView{
            switch selectedIndex{
            case 0:HomeScreenView()
            case 1 : SearchScreenView()
            case 2 :SearchScreenView()
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
                        .font(.system(size: 20))
                        .foregroundColor(selectedIndex==0 ? .black : .gray)
                      
                    
                })
                Spacer()
                Button(action: {
                    selectedIndex = 1
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(selectedIndex==1 ? .black : .gray)
                     
                })
                Spacer()
                Button(action: {
                    selectedIndex = 0
                }, label: {
                    AddButton()
                        .shadow(radius: 20)
                })

                Spacer()
                Button(action: {
                    selectedIndex = 3
                }, label: {
                    Image(systemName: selectedIndex==3 ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                        .foregroundColor(selectedIndex==3 ? .black : .gray)
                       
                })
                Spacer()
                Button(action: {
                    selectedIndex = 4
                }, label: {
                    Image(systemName: selectedIndex==4 ? "person.fill" : "person")
                        .font(.system(size: 20))
                        .foregroundColor(selectedIndex==4 ? .black : .gray)
                       
                })
                
            }
            .frame(height: Screen.maxHeight*0.02, alignment: .center)
            .shadow(radius: 10)
            .padding()
            .ignoresSafeArea()
        
        }
    }
}

struct AddButton : View{
    let colors = Gradient(colors: [Color("cream"),Color("pink"),Color("purple"),Color("blue")])
    var body : some View{
        ZStack{
        Circle()
            .fill(LinearGradient(gradient: colors,startPoint: .bottom,endPoint: .topTrailing))
            .frame(width: Screen.maxWidth*0.16, height: Screen.maxWidth*0.16, alignment: .center)
        Image(systemName: "plus")
                .resizable().frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.05, alignment: .center)
                .accentColor(.white)
        }
    }
    
    
}



struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
