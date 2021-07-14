//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by ashutosh on 26/06/21.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var currentUser : User
    @Environment(\.presentationMode) var presentable
    var body: some View {
        VStack{
        HStack{
            Button {
                self.presentable.wrappedValue.dismiss()
            } label: {
                Text("Cancel").foregroundColor(.black)
            }
            Spacer()
            Text("Edit Profile").bold()
            Spacer()
            Button {
                self.currentUser.updateData()
                self.presentable.wrappedValue.dismiss()
            } label: {
                Text("Done").foregroundColor(.blue).bold()
            }
        }.padding(.leading).padding(.trailing)
            Divider()
            Spacer()
            Image(systemName: "person").resizable().frame(width: Screen.maxWidth*0.2, height: Screen.maxWidth*0.2, alignment: .center).scaledToFit().clipShape(Circle())
            Text("Change profile photo").foregroundColor(.blue).font(.system(size: 14)).bold()
            Divider()
          //  Spacer()
            VStack{
            HStack{
                HStack(spacing:Screen.maxWidth*0.05){
                    VStack(alignment:.leading){
                        Text("Name").padding(.all,Screen.maxWidth*0.02)
                    Text("username").padding(.all,Screen.maxWidth*0.02)
                    Text("Website").padding(.all,Screen.maxWidth*0.02)
                    Text("bio").padding(.all,Screen.maxWidth*0.02)
                    }
                    Spacer()
                    VStack(alignment:.leading,spacing:Screen.maxWidth*0.013){
                        TextField(self.currentUser.fullName, text: self.$currentUser.fullName).padding(.all,Screen.maxWidth*0.015)
                    Divider()
                        TextField(self.currentUser.username, text: self.$currentUser.username).padding(.all,Screen.maxWidth*0.015)
                    Divider()
                        TextField(self.currentUser.website, text: self.$currentUser.website).padding(.all,Screen.maxWidth*0.015)
                    Divider()
                        TextField(self.currentUser.bio, text: self.$currentUser.bio).padding(.all,Screen.maxWidth*0.015)
                }
            }
            }.frame(width: Screen.maxWidth*0.9)
            Divider()
            Text("Switch to Professional account").foregroundColor(.blue).padding(.trailing,Screen.maxWidth*0.35)
            Divider()
                Text("Personal information settings").foregroundColor(.blue).padding(.trailing,Screen.maxWidth*0.38)
            }
            Spacer()
            Spacer()
        }.navigationBarHidden(true)
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
  
    static var previews: some View {
        EditProfileView().environmentObject(User())
    }
}
