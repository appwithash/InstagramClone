//
//  HomeScreenView.swift
//  InstagramClone
//
//  Created by ashutosh on 10/04/21.
//

import SwiftUI
struct HomeScreenView: View {
    @EnvironmentObject var currentUser : User
    var body: some View {
        VStack{
            TopBar()
            ScrollView{
                StoryView().redacted(reason:self.currentUser.isLoadingHomeScreen ? .placeholder : [])
                PostView().redacted(reason:self.currentUser.isLoadingHomeScreen ? .placeholder : [])
            }
        }.navigationBarHidden(true)

      
      
    }
}

//MARK: - TopBar Section
struct TopBar : View{
    @State var onAddPostClicked = false
    var body : some View{
        HStack{
           
            Image("logo").resizable().frame(width: Screen.maxWidth*0.3, height: Screen.maxHeight*0.05, alignment: .leading).padding(.leading,5)
            Spacer()
            
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1.8)
                    .frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.05, alignment: .center)
                Image(systemName: "plus")  .font(.system(size: 16))
                    .accentColor(.black)
            }.padding(.trailing,20)
                .onTapGesture {
                    self.onAddPostClicked.toggle()
                }
                .fullScreenCover(isPresented: $onAddPostClicked){
                    SelectImageToPostView()
                   
                }
            Button(action: {}, label: {
                    Image(systemName: "paperplane")
                    .font(.system(size: 20))
                        .accentColor(.black)
            }).padding(.trailing,Screen.maxWidth*0.05)
            
        }
    }
}
//MARK: - Story Section
struct StoryCellContent : View{
    let colors = Gradient(colors: [Color("orange"),Color("cream"),Color("pink"),Color("purple"),Color("blue")])
    var story : Story
    var body : some View{
        VStack{
            StoryGradient(image: story.profilePicture)
            Text(story.username)
                .font(.custom("username", size: 10))
                .layoutPriority(1)
        }
    }
}

struct FirstStoryCellContent : View{
    let colors = Gradient(colors: [Color("orange"),Color("cream"),Color("pink"),Color("purple"),Color("blue")])
    var story : Story
    var body : some View{
        VStack{
            ZStack{
            StoryGradient(image: story.profilePicture)
                ZStack{
                    Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.blue)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                } .offset(x: 22.0, y: 24.0)
            }
            Text(story.username)
                .font(.custom("username", size: 10))
                .layoutPriority(1)
        }
    }
}



struct StoryView : View{
    private var storiesList : [Story] = [
        Story(username: "Your story", profilePicture:"image2", storyContent: "post2"),
        Story(username: "natasha", profilePicture:"post1", storyContent: "post2"),
        Story(username: "tonystark", profilePicture:"post3", storyContent: "post2"),
        Story(username: "thor", profilePicture:"post4", storyContent: "post2"),
        Story(username: "hulk", profilePicture:"post5", storyContent: "post2"),
        Story(username: "hawkaye", profilePicture:"post6", storyContent: "post2"),
        ]
    var body : some View{
        
       ScrollView(.horizontal,showsIndicators : false){
            HStack{
                ForEach(0..<storiesList.count){  index in
                    if(index==0){
                        FirstStoryCellContent(story: storiesList[index]).padding(.trailing,10).unredacted()
                    }else{
                        StoryCellContent(story: storiesList[index]).padding(.trailing,10)
                    }
            }
            }
            Spacer()
        }
    }
}

//MARK: - Post Section

struct PostView : View{
    @EnvironmentObject var currentUser : User
    var body: some View{
        VStack{
            ForEach(self.currentUser.userHomeFeed){post in
                PostCellContent(post: post).padding(.bottom,10)
            }
        }
}
}

struct PostCellContent: View {
    @StateObject var post : Post
    @State private var onLikevisiblity = false
    @State private var isFirstDoubleTapped = true
    @State var goToComments = false
    var body : some View{
        VStack{
            HStack(alignment:.top,spacing:10){
                post.profileImage
                    .resizable()
                    .frame(width: Screen.maxWidth*0.1, height:Screen.maxWidth*0.1,alignment: .trailing)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.leading)
                    .padding(.top,2)
                VStack(alignment: .leading){
                    Text(post.username).bold().font(.system(size: 14))
                    Text(post.location).font(.system(size: 14))
                }
                Spacer()
                Button(action: {
            
                }, label: {
                    Image(systemName: "ellipsis")
                        .accentColor(.black)
                        .padding()
                        .padding(.trailing,5)
                })
            }
        
            ZStack{
                post.postImage
                .resizable()
                .scaledToFill()
                .frame(width: Screen.maxWidth*0.96, height: Screen.maxWidth*0.96, alignment: .center)
                .cornerRadius(20)
                .clipShape(Rectangle())
                .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                .onTapGesture(count: 2, perform: {
                    self.onLikevisiblity.toggle()
                  
                    if(!post.isLiked){
                        post.isLiked.toggle()
                        if post.isLiked && isFirstDoubleTapped{
                            post.likesCount += 1
                            self.isFirstDoubleTapped = false
                        }
                    }
                })
                Image(systemName: "heart.fill").resizable().frame(width: 350, height: 300, alignment: .center).foregroundColor(.white)
                    .scaleEffect(onLikevisiblity ? 0.0001 : 1)
                    .animation(Animation.default.speed(0.5))
                    .animation(Animation.default.delay(10))
                    .scaleEffect(onLikevisiblity ? 1 : 0.9)
                    .animation(Animation.default.speed(0.5))
                    .scaleEffect(onLikevisiblity ? 0.9 : 1)
                  
                    .animation(Animation.default.speed(0.5))
                    .scaleEffect(onLikevisiblity ? 1 : 0.0001)
                    .animation(Animation.default.speed(0.5))
                  
                    .opacity(onLikevisiblity ? 1 : 0)
                    .shadow(radius: 8)
            }
                
            
            HStack{
                Button(action: {
                    post.isLiked.toggle()
                    if post.isLiked{
                        post.likesCount += 1
                    }else{
                        post.likesCount -= 1
                        self.isFirstDoubleTapped = true
                    }
                    
                }, label: {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.045, alignment: .center)
                        .accentColor(post.isLiked ? .red : .black)
                        .padding(.leading,Screen.maxWidth*0.04)
                    
                    
                })
                NavigationLink(
                    destination:CommentView(post: post),
                    isActive:$goToComments
                ){
                Button(action: {
                    self.goToComments=true
                }, label: {
                    Image(systemName: "message").font(.system(size: 20))
                        .accentColor(.black)
                    
                })  .padding(.leading,Screen.maxWidth*0.01)
                }
                Button(action: {}, label: {
                    Image(systemName: "paperplane").font(.system(size: 20))
                        .accentColor(.black)//.rotationEffect(.degrees(22.5))
                })  .padding(.leading,Screen.maxWidth*0.01)
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "bookmark").resizable()
                       
                       
                })  .frame(width: Screen.maxWidth*0.045, height: Screen.maxWidth*0.05, alignment: .center).foregroundColor(.black)
                    .padding(.trailing,Screen.maxWidth*0.04)
            }.padding(.top,2)
            HStack{
                Text("Liked by").foregroundColor(.gray).font(.system(size: 14))
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("tonystark").bold().accentColor(.black).font(.system(size: 14))
                })
                Text("and").foregroundColor(.gray)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text(String("\(post.likesCount) others")).bold().accentColor(.black).font(.system(size: 14))
                })
               
            }.padding(.trailing,Screen.maxWidth*0.3)
        }
    }
}




//MARK: - Preview HomeScreenView
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView().environmentObject(User())
    }
}

