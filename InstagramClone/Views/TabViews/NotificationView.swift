//
//  NotificationView.swift
//  InstagramClone
//
//  Created by ashutosh on 07/04/21.
//

import SwiftUI

struct NotificationView: View {
//    var notificationList :  [Notifications] = [
//        Notifications( user: User(), notificationType: .isFollowRequest)
//    ]
    @State private var selectedTab : Int = 1
    var body: some View {
        ZStack{
            ScrollView{
            VStack(alignment:.leading){
                Text("Activity").font(.system(size: 25)).bold().padding(.leading).padding(.bottom)
               Text("Today").font(.system(size: 18)).bold().padding(.leading)
                VStack{
                FollowRequestCell(username: "natasha", profilePictureName: "post1")
                StartedFollowingCell(username: "natasha", profilePictureName: "post1")
                    YouMayKnowCell(username: "client.aka.hawkaye", profilePictureName: "post6")
                }
                Divider()
                Text("This Week").font(.system(size: 18)).bold().padding(.leading)
                VStack{
                FollowRequestCell(username: "tony_stark", profilePictureName: "post3")
                    YouMayKnowCell(username: "client.aka.hawkaye", profilePictureName: "post6")
                StartedFollowingCell(username: "captain_america", profilePictureName: "post2")
                }
                Divider()
                Text("This Month").font(.system(size: 18)).bold().padding(.leading)
                VStack{
                    YouMayKnowCell(username: "client.aka.hawkaye", profilePictureName: "post6")
                FollowRequestCell(username: "tony_stark", profilePictureName: "post3")
                StartedFollowingCell(username: "captain_america", profilePictureName: "post2")
                }
           Spacer()
        }//.frame(width: Screen.maxWidth, height: Screen.maxHeight, alignment: .center)
        }
        }.navigationBarHidden(true)
    }
}

struct Notifications : Identifiable{
    var id = UUID()
    var user : User
    var notificationType : NotificationType
}

//MARK: - Notifiation Types

enum NotificationType{
   case isFollowRequest, isLikedComment, isCommentOnPost, isLikedPost, isStartedFollwingYou, youMightKnow
}

//MARK: - NotificationCells

struct FollowRequestCell : View{
    var username : String
    var  profilePictureName : String
    var body : some View{
        HStack{
        Image(profilePictureName).resizable()
            .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
            .scaledToFit()
            .clipShape(Circle())
            Text("\(Text(username).bold()) request to follow you. \(Text("4w").foregroundColor(.gray))").font(.system(size:14))
             
            Spacer()
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.blue)
                        .frame(width: Screen.maxWidth*0.17, height:  Screen.maxWidth*0.07, alignment: .center)
                    Text("Confirm").foregroundColor(.white).font(.system(size: 14))
                }
            }
            
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("gray2"),lineWidth: 1)
                        .frame(width: Screen.maxWidth*0.17, height:  Screen.maxWidth*0.07, alignment: .center)
                    Text("Delete").foregroundColor(.black).font(.system(size: 14))
                }
            }
          //  Spacer()

        }.padding(.leading).padding(.trailing)
    }
}



struct StartedFollowingCell : View{
    var username : String
    var  profilePictureName : String
    var body : some View{
        HStack{
        
        Image(profilePictureName).resizable()
            .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
            .scaledToFit()
            .clipShape(Circle())
            Text("\(Text(username).bold()) started following you. \(Text("4w").foregroundColor(.gray))").font(.system(size:14))
             
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.blue)
                        .frame(width: Screen.maxWidth*0.3, height:  Screen.maxWidth*0.07, alignment: .center)
                    Text("Follow back").foregroundColor(.white).font(.system(size: 14))
                }
            }
            
          

        }.padding(.leading).padding(.trailing)
    }
}

struct YouMayKnowCell : View{
    var username : String
    var  profilePictureName : String
    var body : some View{
        HStack{
        
        Image(profilePictureName).resizable()
            .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
            .scaledToFit()
            .clipShape(Circle())
            Text("\(Text(username).bold()), who you might know, is on instagram. \(Text("4w").foregroundColor(.gray))").font(.system(size:14))
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.blue)
                        .frame(width: Screen.maxWidth*0.3, height:  Screen.maxWidth*0.07, alignment: .center)
                    Text("Follow").foregroundColor(.white).font(.system(size: 14))
                }
            }
            
          

        }.padding(.leading).padding(.trailing)
    }
}



//MARK: - FollowingView
struct FollowingView : View{
    var body: some View{
        VStack(spacing:0){
            ScrollView{
            ZStack{
                SearchBar()
                Image.init(systemName: "magnifyingglass")
                    .offset(x:-155)
                    .foregroundColor(.gray)
            }.padding()
            FollowingSection()
        }
        }
    }
}

struct FollowingCell : View{
    let person : FollowingPerson
    var body: some View{
        HStack{
            Image(person.profilePicture)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60, alignment: .center)
            
            VStack(alignment:.leading){
                Text(person.username)
                    .foregroundColor(.black)
                    .bold()
                Text(person.fullName)
                    .foregroundColor(.black)
                    .font(.system(size:15))
            }.padding(.leading,10)
            Spacer()
            Button(action: {
                
            }, label: {
                Text("remove")
                    .frame(width: 76, height: 28, alignment: .center)
                    .accentColor(.black)
                    .background(Color.white)
                    .cornerRadius(10.0)
            })
            .frame(width: 80, height: 30, alignment: .center)
            .background(Color("gray2"))
            .cornerRadius(10.0)
            
            Image(systemName: "ellipsis").rotationEffect(.degrees(90))

        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}


struct FollowingSection : View{
    
    private var followingList : [FollowingPerson] = [
        FollowingPerson(username: "natasha", fullName: "Natasha Romenoff", profilePicture: "post1"),
        FollowingPerson(username: "tonystark", fullName: "Tony Stark", profilePicture: "post3"),
        FollowingPerson(username: "thor", fullName: "Thor", profilePicture: "post4"),
        FollowingPerson(username: "thehulk", fullName: "Bruce Banner", profilePicture: "post5"),
        FollowingPerson(username: "hawkaye", fullName: "Clint barton", profilePicture: "post6"),
        FollowingPerson(username: "jessica", fullName: "Jessica Davis", profilePicture: "image1"),
        FollowingPerson(username: "steverogers", fullName: "Steve Rogers", profilePicture: "image2"),
        FollowingPerson(username: "hanna", fullName: "Hanna Bakers", profilePicture: "image3"),
        FollowingPerson(username: "clay", fullName: "Clay Jensen", profilePicture: "image4"),
        FollowingPerson(username: "justin", fullName: "justin foley", profilePicture: "image5"),
        ]
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            ForEach(followingList){person in
                FollowingCell(person: person)
            }
        }
    }
}




struct FollowingPerson : Identifiable{
    var id=UUID()
    let username : String
    let fullName : String
    let profilePicture : String
}

//MARK: - NotificationView
struct NotificationSection : View{
    var notificationList : [Notification] = [
                                        
                                    ]
    var body: some View{
        Text("You View")
    }
}



struct Notification : Identifiable{
    var id = UUID()
    
}



struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
