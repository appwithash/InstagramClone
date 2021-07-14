//
//  SearchScreen.swift
//  InstagramClone
//
//  Created by ashutosh on 07/04/21.
//

import SwiftUI
import AVKit

struct SearchScreenView: View {
    @State private var isTabSpring = false
    var body: some View {
        VStack(spacing:0){
       
            ZStack{
                SearchBar()
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .offset(x:-175)
                    .foregroundColor(.gray)
            }.frame(width: Screen.maxWidth, height: Screen.maxWidth*0.1)
     
            FilterTabView()
              //  .offset(x:10,y:-20)
                .offset(x: isTabSpring ? 10 : 200, y: 0)
                .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
                //.animation(Animation.default)
                .onAppear(){
                    self.isTabSpring.toggle()
                }.frame(width: Screen.maxWidth, height: Screen.maxHeight*0.07, alignment: .center)
            ScrollView{
            Image("image1")
                .resizable()
                .scaledToFit()
                .frame(height:Screen.maxHeight*0.5)
                .padding(.all,2)
           SearchViewPostFeed()
            }
            .offset(x: 0, y: isTabSpring ? 0 : 100)
            .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
            
       
        } .navigationBarHidden(true)
}
}

struct SearchBar : View{
    @State var searchedText = ""
    @State var isTyping : Bool = false
    var body : some View{
        TextField("Search", text: $searchedText)
            .padding(.leading,10)
            .frame(width: Screen.maxWidth*0.8, height: 30, alignment: .center)
            .padding(.horizontal, 25)
            .padding(.vertical,5)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isTyping = true
            }
    }
}

//MARK: - SearchViewPostFeed

struct SearchViewPostFeed : View{
    private var gridItem = [GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315)),GridItem(.fixed(Screen.maxWidth*0.315))]
    
    var searchViewPostFeedList : [Post] = [
        Post(username: "sakshi", postImage: Image("image1"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image2"), location: "dehradun", profileImage:  Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image3"), location: "dehradun", profileImage:  Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image4"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image5"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image6"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image7"), location: "dehradun", profileImage:Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image8"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image9"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "sakshi", postImage:  Image("image10"), location: "dehradun", profileImage: Image("image1"), isLiked: false, likesCount: 100),
        Post(username: "natasha", postImage: Image("post1"), location: "canada", profileImage: Image("image1"),isLiked:false, likesCount: 100),
        Post(username: "steverogers", postImage: Image("post2"), location: "america", profileImage: Image("image1"),isLiked:false, likesCount: 300),
        Post(username: "tonystark", postImage: Image("post3"), location: "canada", profileImage: Image("image1"),isLiked:false, likesCount: 3000),
        Post(username: "thor", postImage: Image("post4"), location: "canada", profileImage: Image("image1"), isLiked:false,likesCount: 100),
        Post(username: "hulk", postImage: Image("post5"), location: "canada", profileImage: Image("image1"), isLiked:false,likesCount: 100),
        Post(username: "hawkaye", postImage: Image("post6"), location: "canada", profileImage: Image("image1"), isLiked:false,likesCount: 100),
    ]
    
    struct SearchViewPostCell : View{
        var post : Post
        var index : Int
        var body : some View{
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                post.postImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: Screen.maxWidth*0.325, height: Screen.maxWidth*0.325, alignment: .center)
                    .cornerRadius(5.0)
            }).padding(.leading,1).padding(.trailing,1)
        }
    }
    var body : some View{
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: gridItem,spacing:1){
                ForEach(0..<searchViewPostFeedList.count,id:\.self){index in
                    VStack{
                        SearchViewPostCell(post: searchViewPostFeedList[index],index: index).padding(.all,1)
                    }
                }
            }.padding(.trailing,10)
            .padding(.leading,10)
        }
    }
}

//MARK: - Tabs

struct FilterTabCell : View{
    var tab : TabList
    var body : some View{
        Button(action: {}, label: {
            Text(tab.tabName)
                .foregroundColor(.black)
                .padding(.all,10)
                .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("gray2"), lineWidth: 1))
        })
    }
}

struct TabList : Identifiable{
    var id = UUID()
    var tabName : String
}

struct FilterTabView : View{
    var tabList : [TabList] = [TabList( tabName: "IGTV"),TabList( tabName:"Travel"),TabList( tabName:"Architecture"),TabList( tabName:"Decor"),TabList( tabName:"Style"),TabList( tabName:"Food"),TabList( tabName:"Art"),TabList( tabName:"TV & Movies"),TabList( tabName:"Music"),TabList( tabName:"Sports")]
    var body : some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
            ForEach(tabList){tab in
                FilterTabCell(tab:tab)
            }
            }
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
    }
}
