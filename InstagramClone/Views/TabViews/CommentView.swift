//
//  CommentView.swift
//  InstagramClone
//
//  Created by ashutosh on 15/07/21.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var post : Post
    @EnvironmentObject var currentUser : User
    @Environment(\.presentationMode) var presentationMode
    @State var myComment = ""
    @ObservedObject var newComment = Comment(username: "", profileImage: Image("image1"), commentData: "")
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "chevron.left").padding(.leading)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Comments").padding(.leading,5)
                Spacer()
                Image(systemName: "paperplane").padding(.trailing)
            }
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment:.top){
                post.profileImage
                    .resizable()
                    .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
                VStack(alignment:.leading,spacing:Screen.maxHeight*0.01){
                Text("\(Text(post.username).bold()) \(post.postCaption)")
              
                    Text("2w").foregroundColor(.gray)
                }
            }.padding(.leading).padding(.trailing)
            Divider()
                VStack{
                ForEach(self.post.postComments){comment in
                    Commentcell(comment: comment)
                }
                
                }
            }
          
            HStack{
                currentUser.profilePicture
                .resizable()
                .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
                .scaledToFit()
                .clipShape(Circle())
                ZStack{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.1)
                        .stroke(Color.gray)
                    HStack{
                    TextField("Add a comment as \(currentUser.username)", text: $myComment)
                        
                        Text("Post").foregroundColor(.blue).bold()
                            .onTapGesture {
                              
                                self.newComment.commentData = myComment
                                self.newComment.username = currentUser.username
                                self.newComment.profileImage = currentUser.profilePicture
                                post.addCommentToFirebase(post: post, comment: newComment)
                                self.post.postComments.insert(newComment, at: 0)
                                self.myComment=""
                            }
                    }.padding(.leading).padding(.trailing)
                }
                .frame(width: Screen.maxWidth*0.78, height: Screen.maxWidth*0.12, alignment: .center)
            }
        }.navigationBarHidden(true)
        .onAppear{
            
            self.post.fetchComments(post: post)
        }
    }
}

struct Commentcell : View{
    
    var comment : Comment
    var body: some View{
        HStack{
            comment.profileImage
            .resizable()
            .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
            .scaledToFit()
            .clipShape(Circle())
            VStack(alignment:.leading){
            Text("\(Text(comment.username).bold()) \(comment.commentData)")
                HStack(spacing:Screen.maxWidth*0.03){
                    Text("\(comment.timeOfcomment)").foregroundColor(.gray).font(.system(size: 14))
                    Text("\(comment.commentLikesCount) likes").foregroundColor(.gray).font(.system(size: 14))
                    Text("reply").foregroundColor(.gray).font(.system(size: 14))
                }
            }
            Spacer()
            Image(systemName: "heart").font(.system(size: 14))
        }.padding(.leading).padding(.trailing)
      
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(post: Post(username: "ashutosh", postImage: Image("image1"), location: "dehradun", profileImage: Image("post1"), isLiked: false, likesCount: 10, postNumber: 0, postEmail: "")).environmentObject(User())
    }
}
