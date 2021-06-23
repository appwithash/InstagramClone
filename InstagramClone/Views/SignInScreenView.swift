//
//  SignInScreenView.swift
//  InstagramClone
//
//  Created by ashutosh on 23/06/21.
//

import SwiftUI

struct SignInScreenView: View {
   // @EnvironmentObject var newUser :User
   
    var body: some View {
        ZStack{
        CreateUsername()
        }
    }
}

struct CreateUsername : View{
    @State var username = ""
    @State var isLogIn = false
    var body: some View{
        VStack(spacing:10){
            Image(systemName: "plus")
                .rotationEffect(.degrees(45)).font(.title)
                .padding(.trailing,Screen.maxWidth*0.8)
            Text("Create username").font(.title).fontWeight(.light)
            Text("choose a username for your account. You can always change it later")
                .foregroundColor(.gray).multilineTextAlignment(.center).font(.system(size: 14))
                .frame(width: Screen.maxWidth*0.9, height: Screen.maxWidth*0.1, alignment: .center)
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray,lineWidth:1)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                TextField("username", text: $username )
                    .textCase(.lowercase)  .font(.system(size: 14))
                    .padding()
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
            }
            NavigationLink(
                destination: CreatePassword(),
               label: {
                Text("next").foregroundColor(.white)
                    .fontWeight(.bold)
            })   .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
            .background(Color.blue)
            .cornerRadius(8.0)
  
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct CreatePassword : View{
    @State var password = ""
    @State var isLogIn = false
    var body: some View{
        VStack(spacing:10){
            Image(systemName: "plus")
                .rotationEffect(.degrees(45)).font(.title)
                .padding(.trailing,Screen.maxWidth*0.8)
            Text("Create password").font(.title).fontWeight(.light)
            Text("We can remember the password, so you won't need to enter it again it on your iCloud devices.")
                .foregroundColor(.gray).multilineTextAlignment(.center).font(.system(size: 14))
                .frame(width: Screen.maxWidth*0.9, height: Screen.maxWidth*0.1, alignment: .center)
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray,lineWidth:1)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                TextField("username", text: $password )
                    .textCase(.lowercase)  .font(.system(size: 14))
                    .padding()
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
            }
            NavigationLink(
                destination: TabContainerView(),
               label: {
                Text("next").foregroundColor(.white)
                    .fontWeight(.bold)
            })   .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
            .background(Color.blue)
            .cornerRadius(8.0)
            
            Spacer()
        }.navigationBarHidden(true)
    }
}



struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}
