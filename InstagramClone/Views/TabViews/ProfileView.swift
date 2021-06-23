//
//  ProfileView.swift
//  InstagramClone
//
//  Created by ashutosh on 07/04/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ProfileCell(myProfile: PersonProfile(username: "steverogers", fullName: "Steve Rogers", bio: "captain America", postCount: 20, followersCount: 10, followingCount: 32, backgroundImage: "image5", profileImage: "image1", myPostList: ["image1","image2","image3"]))
    }
}

struct ProfileCell : View{
    let myProfile : PersonProfile
    @State private var selectedTab = 0
    var body : some View{
        VStack{
            HStack{
                Text(myProfile.username).font(.system(size: 25)).bold()
            }
            ScrollView{
            HStack{
                Spacer()
                ZStack{
            Image(myProfile.profileImage)
                .resizable()
                .frame(width: Screen.maxWidth*0.2, height:  Screen.maxWidth*0.2, alignment: .leading)
                .clipShape(Circle())
                ZStack{
                    Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.blue)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                } .offset(x: 25.0, y: 30.0)
            }
                Spacer()
                    Spacer()
                    VStack{
                    Text("\(myProfile.postCount)").font(.system(size: 14)).bold()
                        Text("Posts").font(.system(size: 14)).bold()
                    }
                    Spacer()
                    VStack{
                    Text("\(myProfile.followersCount)").font(.system(size: 14)).bold()
                        Text("Followers").font(.system(size: 14)).bold()
                    }
                    Spacer()
                    VStack{
                    Text("\(myProfile.followingCount)").font(.system(size: 14)).bold()
                        Text("Following").font(.system(size: 14)).bold()
                    }
                    Spacer()
            }
            VStack(alignment:.leading){
                Text(myProfile.fullName).font(.system(size: 14)).bold()
                Text(myProfile.bio).font(.system(size: 14)).padding(.bottom,Screen.maxWidth*0.1)
            }.padding(.trailing,250)
            Spacer()
        //    HStack{
                Button(action: {
                    
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).stroke(Color("gray2"),lineWidth:1)
                    Text("Edit Profile").font(.system(size: 14))
                        .foregroundColor(.black)
                       
                    }.frame(width: Screen.maxWidth*0.9, height: Screen.maxHeight*0.04, alignment: .center)
                })
          //  }
          
        //    Divider()
            ZStack{
            HStack{
              
                ZStack{
                Image(systemName: "circle.grid.3x3")
                        .font(.system(size: 18))
                        .foregroundColor(selectedTab==0 ? .black : .gray)
                }
                .frame(width: Screen.maxWidth*0.5, height: Screen.maxHeight*0.05, alignment: .center)
                    .cornerRadius(3.0, antialiased: true)
              
                .onTapGesture {
                    self.selectedTab = 0
                }
                ZStack{
                    Image(systemName: "person.badge.plus").font(.system(size: 18))
                        .foregroundColor(selectedTab==1 ? .black : .gray)
                }
                .frame(width: Screen.maxWidth*0.5, height: Screen.maxHeight*0.05, alignment: .center)
                    .cornerRadius(3.0, antialiased: true)
                    .onTapGesture {
                        self.selectedTab = 1
                    }
            }.frame(width: Screen.maxWidth*0.1, height: Screen.maxHeight*0.01, alignment: .center)
                Capsule()
                    .frame(width: Screen.maxWidth*0.5, height: 2, alignment: .bottom)
                    .offset(x:selectedTab==0 ?  -Screen.maxWidth*0.25 :  Screen.maxWidth*0.25,y:Screen.maxHeight*0.028)
            }.frame(width: Screen.maxWidth*0.5, height: Screen.maxHeight*0.04, alignment: .center)
            VStack(spacing:3){
            Divider()
            if selectedTab==0{
                MyPosts()
            }else{
                TaggedPosts()
            }
                }
                
            }
        }.navigationBarHidden(true)
    }
}
//MARK: - MyPosts
struct MyPosts : View {
    private var gridItem = [GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315))]
    
    
    var myPostList : [Post] = [
        Post(username: "sakshi", postName: "image10", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image9", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image8", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image7", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image5", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image6", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image5", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image2", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "post4", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100)]
    var body : some View{
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: gridItem,spacing:1){
            ForEach(myPostList){post in
            PostGridCell(post: post)
        }
        }
        }
    }
}

struct PostGridCell : View{
    var post : Post
    //var index : Int
    var body : some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(post.postName)
                .resizable()
                .scaledToFill()
                .frame(width: Screen.maxWidth*0.325, height: Screen.maxWidth*0.325, alignment: .center)
                .cornerRadius(5.0)
        }).padding(.bottom,2)
    }
}

//MARK: - TaggedPosts
struct TaggedPosts : View {
    private var gridItem = [GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315))]
    
    var taggedPostList : [Post] = [
        Post(username: "sakshi", postName: "post2", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "post4", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image10", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image8", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        Post(username: "sakshi", postName: "image5", location: "dehradun", profilePicture: "image1", isLiked: false, likesCount: 100),
        ]
    var body : some View{
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: gridItem,spacing:1){
            ForEach(taggedPostList){post in
                PostGridCell(post: post)
        }
        }
        }
    }
}



struct PersonProfile : Identifiable{
    var id = UUID()
    let username : String
    let fullName : String
    let bio : String
    let postCount : Int
    let followersCount : Int
    let followingCount : Int
    let backgroundImage : String
    let profileImage : String
    let myPostList : [String]
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
