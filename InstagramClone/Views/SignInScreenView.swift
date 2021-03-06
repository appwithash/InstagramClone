//
//  SignInScreenView.swift
//  InstagramClone
//
//  Created by ashutosh on 23/06/21.
//

import SwiftUI

struct SignInScreenView: View {
    @EnvironmentObject var newUser :User
  
   @State var isLogIn = false
    var body: some View {
        ZStack{
                CreateUsername()
        }
           
    }
}

struct CreateUsername : View{
    @EnvironmentObject var newUser :User
    @Environment(\.presentationMode) var presentable
    @State var isLogIn = false
    @State var goToPasswordScreen = false
    var body: some View{
        VStack(spacing:10){
            Image(systemName: "plus")
                .rotationEffect(.degrees(45)).font(.title)
                .padding(.trailing,Screen.maxWidth*0.8)
                .onTapGesture {
                    self.presentable.wrappedValue.dismiss()
                }
 Text("Create username").font(.title).fontWeight(.light)
                        Text("choose a username for your account. You can always change it later")
                           .foregroundColor(.gray).multilineTextAlignment(.center).font(.system(size: 14))
                            .frame(width: Screen.maxWidth*0.9, height: Screen.maxWidth*0.1, alignment: .center)
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray,lineWidth:1)
                                .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                            TextField("username", text: $newUser.username )
                                .textCase(.lowercase)  .font(.system(size: 14))
                                .padding()
                                .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                        }
                        NavigationLink(
                            destination: CreatePassword(),
                            isActive : $goToPasswordScreen,
                            label: {
                            Text("next").foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
                              .background(Color.blue)
                              .cornerRadius(8.0)
                              .onTapGesture {
                                print("username : \(newUser.username)")
                                self.goToPasswordScreen.toggle()
                               
                              }
                        })
                            .disabled(self.newUser.username.isEmpty)
                            .opacity(self.newUser.username.isEmpty ? 0.5 : 1)
            
                        Spacer()
        }.navigationBarHidden(true)
    }
}

struct CreatePassword : View{
    @EnvironmentObject var newUser :User
    @Environment(\.presentationMode) var presentable
    @State var showPassword = false
    @State var goToEmailScreen = false
    var body: some View{
        VStack(spacing:10){
            Image(systemName: "plus")
                .rotationEffect(.degrees(45)).font(.title)
                .padding(.trailing,Screen.maxWidth*0.8)
                .onTapGesture {
                    self.presentable.wrappedValue.dismiss()
                }
            Text("Create password").font(.title).fontWeight(.light)
            Text("We can remember the password, so you won't need to enter it again it on your iCloud devices.")
                .foregroundColor(.gray).multilineTextAlignment(.center).font(.system(size: 14))
                .frame(width: Screen.maxWidth*0.9, height: Screen.maxWidth*0.1, alignment: .center)
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray,lineWidth:1)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
               
                    if showPassword{
                TextField("password", text: $newUser.password )
                    .textCase(.lowercase)  .font(.system(size: 14))
                    .padding()
                        .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                        
                    }else{
                        SecureField("password", text: $newUser.password )
                            .textCase(.lowercase)  .font(.system(size: 14))
                            .padding()
                                .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                    }
                
            }
           CheckBoxView(checked: $showPassword)
            NavigationLink(
                destination: EnterEmail(),
                isActive: $goToEmailScreen,
               label: {
                Text("next").foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    .onTapGesture {
                        self.goToEmailScreen.toggle()
                        print("PASSWORD : \(newUser.password)")
                    }
                    
            }).disabled(self.newUser.password.isEmpty).opacity(self.newUser.password.isEmpty ? 0.5 : 1)
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct EnterEmail : View{
    @EnvironmentObject var newUser :User
    @State var isLogIn = false
    var body: some View{
        VStack(spacing:10){
          Spacer()
            Text("Welcome to Instagram,\(newUser.username)").font(.title).fontWeight(.light).multilineTextAlignment(.center)
                .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.1, alignment: .center)
                
           
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray,lineWidth:1)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
                TextField("email", text: $newUser.email )
                    .textCase(.lowercase)  .font(.system(size: 14))
                    .padding()
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.055, alignment: .center)
            }

                Text("sign In").foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.05, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    .onTapGesture {
                        print("EMAIL : \(newUser.email)")
                        newUser.signIn()
                    }
            Spacer()
            Spacer()
        }.navigationBarHidden(true)
            .overlay( LoadingScreen().opacity(self.newUser.isLoading ? 1 : 0).ignoresSafeArea())
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        HStack{
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
            Text("show password").font(.system(size: 14)).padding(.trailing,Screen.maxWidth*0.6)
        }
        
    }
}


struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView().environmentObject(User())
    }
}
