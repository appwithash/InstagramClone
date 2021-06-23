//
//  ContentView.swift
//  InstagramClone
//
//  Created by ashutosh on 05/04/21.
//

import SwiftUI

struct LoginScreenView: View {
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var goToHomeScreen = false
    var body: some View {
        ZStack{
        NavigationView{
        VStack{
            Text("English(United States)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.bottom,Screen.maxHeight*0.1)
            
            VStack(spacing : 12.0){
                Image("logo").resizable().frame(width: Screen.maxWidth*0.4, height: Screen.maxHeight*0.07, alignment: .leading)
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray,lineWidth:1)
                        .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                    TextField("Phone number ,email or username",text: $username)
                        .textCase(.lowercase)  .font(.system(size: 14))
                        .padding()
                        .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                }
                    
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray,lineWidth:1)
                        .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                SecureField("password",text: $password)  .font(.system(size: 14))
                    .padding()
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
                }
                NavigationLink(
                    destination: TabContainerView(),
                    isActive: $goToHomeScreen){
                Button(action: {
                    self.goToHomeScreen=true
                }, label: {
                    Text("Log In").foregroundColor(.white)
                        .fontWeight(.bold)
                })   .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
                .background(Color.blue)
                .cornerRadius(8.0)
                }
                HStack{
                    Text("Forget your login details?")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Button(action: {
                        
                    }, label: {
                        Text("Get help Sign in.")
                            .font(.system(size: 14))
                            .bold().foregroundColor(.black)
                    })
                }
                Button(action: {
                    
                }, label: {
                    Text("Log in with facebook")
                        .bold()  .font(.system(size: 14))
                        .foregroundColor(.blue)
                })
             
                Spacer()
                Spacer()
                Divider()
                HStack{
                Text("Didn't have an account?")
                    .foregroundColor(.gray) .font(.system(size: 14))
                    NavigationLink(destination: SignInScreenView()) {
                        Text("Sign up").bold().foregroundColor(.black).font(.system(size: 14))
                    
                    }
                }
            }
        
        }
        }.navigationBarHidden(true)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
