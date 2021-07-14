//
//  MakePostView.swift
//  InstagramClone
//
//  Created by ashutosh on 13/07/21.
//

import SwiftUI

struct MakePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var currentUser : User
    @Binding var image : Image!
    @State var caption = ""
    @State var shareOnFacebook = false
    @State var shareOnTwitter = false
    @State var shareOnTumblr = false
   @ObservedObject var newPost = Post()
    var body: some View {
        VStack(alignment:.leading){
            VStack{
        HStack{
            Image(systemName: "chevron.left").padding(.leading)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("New Post").bold().padding(.leading)
            Spacer()
            Text("Share").foregroundColor(.blue).padding(.trailing)
                .onTapGesture {
                    print("postcount=\(currentUser.userPostList)")
                    newPost.likesCount = 0
                    newPost.isLiked=false
                    newPost.location="dehradun"
                    newPost.username=currentUser.username
                    newPost.profileImage=currentUser.profilePicture
                    newPost.postImage = image
                    self.currentUser.userPostList.append(newPost)
                    print("postcount=\(currentUser.userPostList)")
                    presentationMode.wrappedValue.dismiss()
                }
        }
            Divider()
            }
            VStack{
            HStack{
                image
                    .resizable()
                    .frame(width: Screen.maxWidth*0.17, height: Screen.maxWidth*0.17, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ZStack{
                    TextField("Write a caption...", text: $caption).padding(.bottom,Screen.maxWidth*0.05)
                   
                } .frame(height: Screen.maxWidth*0.17, alignment: .center)
                
            }.padding(.all,Screen.maxWidth*0.02)
            Divider()
            }
            VStack{
            HStack{
                Text("Tag people").padding(.leading)
                Spacer()
                Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.gray)
            }
            Divider()
            }
            VStack{
            HStack{
                Text("Add location").padding(.leading)
                Spacer()
                Image(systemName: "chevron.right").padding(.trailing).foregroundColor(.gray)
            }
            Divider()
            }
            VStack{
            HStack{
                Text("Post on other accounts").padding(.leading)
                Spacer()
                Image(systemName: "chevron.down").padding(.trailing).foregroundColor(.gray)
            }
                VStack(spacing:Screen.maxWidth*0.04){
                    HStack{
                        Text("Facebook").padding(.leading)
                        Spacer()
                        Toggle("", isOn: $shareOnFacebook).padding(.trailing)
                    }
                    HStack{
                        Text("Twitter").padding(.leading)
                        Spacer()
                        Toggle("", isOn: $shareOnTwitter).padding(.trailing)
                    }
                    HStack{
                        Text("Tumblr").padding(.leading)
                        Spacer()
                        Toggle("", isOn: $shareOnTumblr).padding(.trailing)
                    }
                }
            Divider()
            }
            HStack{
                Text("Advanced setting")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.leading)
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }.padding(.bottom)
            Divider()
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct MakePostView_Previews: PreviewProvider {
    static var previews: some View {
        MakePostView(image: .constant(Image("post1")))
    }
}
