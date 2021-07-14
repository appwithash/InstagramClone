//
//  ChatListView.swift
//  InstagramClone
//
//  Created by ashutosh on 08/04/21.
//

import SwiftUI

struct MessagesScreenView: View {
    @EnvironmentObject var currentUser : User
    @State var selectedTab = 1
    var body: some View {
        VStack{
            HStack{
                HStack{
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                Text(currentUser.username).font(.title2).bold()
                Button {
                    
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                }.padding(.leading)
               Spacer()
                Spacer()
                HStack(spacing:Screen.maxWidth*0.05){
                Button {
                    
                } label: {
                    Image(systemName: "video")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                }.padding(.trailing)
               
            }
            ScrollView(.vertical, showsIndicators: false){
            HStack{
                Spacer()
                ZStack{
                    Text("All").bold().foregroundColor(self.selectedTab==1 ? .black : .gray)
                    Capsule()
                        .frame(width: Screen.maxWidth*0.5, height: Screen.maxHeight*0.001, alignment: .center)
                        .offset(y:Screen.maxHeight*0.02)
                        .opacity(self.selectedTab==1 ? 1 : 0)
                }.frame(width:Screen.maxWidth*0.5)
                    .onTapGesture {
                        self.selectedTab=1
                    }
                Spacer()
                Spacer()
                ZStack{
                Text("Rooms").bold().foregroundColor(self.selectedTab==2 ? .black : .gray)
                    Capsule()
                        .frame(width: Screen.maxWidth*0.5, height: Screen.maxHeight*0.001, alignment: .center)
                        .offset(y:Screen.maxHeight*0.02)
                        .opacity(self.selectedTab==2 ? 1 : 0)
                }.frame(width:Screen.maxWidth*0.5)
                    .onTapGesture {
                        self.selectedTab=2
                    }
              //  Spacer()
            }.padding(.top)
            Divider()
                switch selectedTab{
                case 1 : ChatListView()
                case 2 : RoomsView()
                default: Text("error")

                }
            }
        }.navigationBarHidden(true)
    }
}

//MARK: - Chat list
struct ChatListView : View{
    var chatList : [ChatPerson] = [
        ChatPerson(profilePicture: Image("post1"), fullName: "Natasha Romenoff", lastMessage: "Seen"),
        ChatPerson(profilePicture: Image("post2"), fullName: "Steve Rogers", lastMessage: "language"),
        ChatPerson(profilePicture: Image("post3"), fullName: "Tony Stark", lastMessage: "peter"),
        ChatPerson(profilePicture: Image("post4"), fullName: "Thor", lastMessage: "Seen"),
        ChatPerson(profilePicture: Image("post5"), fullName: "Hawkaye", lastMessage: "Seen"),
        
    ]
    var suggestionChatList : [ChatPerson] = [
        ChatPerson(profilePicture: Image("image1"), fullName: "Peter Parker", lastMessage: "Tap to chat"),
        ChatPerson(profilePicture: Image("image2"), fullName: "Sam Winchester", lastMessage: "Tap to chat"),
        ChatPerson(profilePicture: Image("image3"), fullName: "Dean Winchester", lastMessage: "Tap to chat"),
        ChatPerson(profilePicture: Image("image4"), fullName: "Loki", lastMessage: "Tap to chat"),
        ChatPerson(profilePicture: Image("image5"), fullName: "Odin", lastMessage: "Tap to chat"),
        
    ]
    var body: some View{
        VStack{
            ZStack{
            SearchBar(searchedText: "", isTyping: false)
                Image(systemName: "magnifyingglass").font(.system(size: 14))
                    .offset(x:-Screen.maxWidth*0.42).foregroundColor(.gray)
            }.padding(.bottom,Screen.maxHeight*0.01)
            VStack{
            ForEach(chatList){person in
                ChatpersonView(person: person)
            }
            }.padding(.leading).padding(.trailing)
            
            Text("Suggestions").bold()
                .padding(.top,8)
                .padding(.trailing,Screen.maxWidth*0.65)
            VStack{
            ForEach(suggestionChatList){person in
                ChatpersonView(person: person)
            }
            }.padding(.leading).padding(.trailing)
        }.navigationBarHidden(true)
    }
}

struct ChatPerson : Identifiable{
    let id = UUID()
    let profilePicture : Image
    let fullName : String
    let lastMessage : String
}
struct ChatpersonView : View{
    let person : ChatPerson
    var body: some View{
        HStack{
            HStack{
            person.profilePicture.resizable()
                    .scaledToFit()
                .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
                .background(Color.black)
                .clipShape(Circle())
            VStack(alignment:.leading){
                Text(person.fullName)
                Text(person.lastMessage).foregroundColor(.gray)
            }
            }.padding(.leading)
            Spacer()
            Image(systemName: "camera").padding(.trailing)
        }
    }
}

//MARK: - RoomsView

struct RoomsView: View{
    var body: some View{
    
            VStack(spacing:Screen.maxWidth*0.05){
                Spacer().frame(height: Screen.maxHeight*0.2)
                HStack{
                   
                    Capsule()
                        .frame(width: Screen.maxWidth*0.008, height: Screen.maxHeight*0.012, alignment: .center)
                        .rotationEffect(.degrees(-25))
                        .offset(x: -Screen.maxWidth*0.04, y: Screen.maxHeight*0.01)
                    
                    Capsule()
                        .frame(width: Screen.maxWidth*0.008, height: Screen.maxHeight*0.012, alignment: .center)
                    
                    Capsule()
                        .frame(width: Screen.maxWidth*0.008, height: Screen.maxHeight*0.012, alignment: .center)
                        .rotationEffect(.degrees(25))
                        .offset(x: Screen.maxWidth*0.04, y: Screen.maxHeight*0.01)
                }
                    ZStack{
                        Color.white
                    //    LinearGradient(, startPoint: , endPoint: .top)
                        LinearGradient(gradient: Gradient(colors:  [Color("orange"),Color("cream"),Color("pink"),Color("purple"),Color("blue")]), startPoint: .bottomLeading, endPoint: .top)
                            .mask(
                                ZStack{
                                Image(systemName: "video")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Image(systemName: "plus")
                                    .offset(x:-Screen.maxWidth*0.02)
                                    .font(.system(size: 25))
                              
                            }
                            )
                        
                    }.frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.1, alignment: .center)
                        .rotationEffect(.degrees(-10))
                   
               
                Capsule().frame(width: Screen.maxWidth*0.15, height: Screen.maxHeight*0.004, alignment: .center)
                    .foregroundColor(Color("gray2"))
            Text("Video chat with anyone").font(.title2).bold()
            Text("create a room to video chat with anyone, even if they dont have instagram")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .frame(width:Screen.maxWidth*0.9)
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: Screen.maxWidth*0.015)
                        Text("Create Room").bold().foregroundColor(.white)
                    }.frame(width: Screen.maxWidth*0.3, height: Screen.maxHeight*0.05, alignment: .center)
                }

            }.navigationBarHidden(true)
    
    }
}


struct MessagesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesScreenView().environmentObject(User())
    }
}
