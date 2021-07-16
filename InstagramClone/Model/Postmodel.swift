//
//  Postmodel.swift
//  InstagramClone
//
//  Created by ashutosh on 13/07/21.
//

import SwiftUI
import Firebase
class Post : Identifiable,ObservableObject{
    @AppStorage("currentUser") var currentEmail = ""
    @AppStorage("count") var count=1
    var id = UUID()
    var username : String = ""
    var postImage : Image = Image(systemName: "person")
    var location : String = ""
    var profileImage : Image = Image(systemName: "person")
    var postImageUrl=""
    var postEmail=""
    var postCaption="this is my post caption i am so excited about it so can you help me with that i will be very helpful Many combine operators are configured with code provided by you, written in a closure. Most diagrams will not attempt to include it in the diagram. It is implied that any code you provide through a closure in Combine will be used within the box rather than explicitly detailed."
    @Published var postComments : [Comment]=[]
    @Published var isLiked : Bool = false
   @Published var likesCount : Int = 0
    @Published var postNumber : Int = 0
    @Published var commentCount = 1
    init(){}
    init(username : String,postImage:Image,location : String,profileImage:Image,isLiked:Bool,likesCount:Int,postNumber:Int=0,postEmail:String) {
        self.username=username
        self.postImage=postImage
        self.location=location
        self.profileImage=profileImage
        self.isLiked=isLiked
        self.likesCount=likesCount
        self.postComments=[ Comment(username: "ashutosh", profileImage: Image("post1"), commentData: "myComment"), Comment(username: "Ashutosh", profileImage:  Image("post1"), commentData: "myComment")]
        self.postNumber=postNumber
        self.postEmail=postEmail
    }
    
    func addCommentToFirebase(post : Post,comment : Comment){
        let db = Firestore.firestore()
        db.collection("Users/\(self.postEmail)/myPostList/Post\(post.postNumber)/Comments/").document("comment\(post.commentCount)").setData([
                                                                                                                "username" : comment.username,
                                                                                                               "commentData" : comment.commentData,
                                                                                                               "commentLikesCount" : comment.commentLikesCount,
                                                                                                               "timeOfComment" : comment.timeOfcomment
        ])
        post.commentCount+=1
    }
    
    func fetchComments(post:Post){
        post.postComments=[]
         let db = Firestore.firestore()
        print("POSTEMAIL-\(post.postEmail)")
         db.collection("Users/\(post.postEmail)/myPostList/Post\(post.postNumber)/Comments").getDocuments(source: .server) { (querySnapshot, error) in
             if error != nil{
                 print(error!.localizedDescription)
             }else{
                 for document in querySnapshot!.documents{
                     let commentData = document.get("commentData") as! String
                     let username =  document.get("username") as! String
                     let timeOfComment =  document.get("timeOfComment") as! String
                     let commentLikesCount =  document.get("commentLikesCount") as! Int
                     let comment = Comment(username: username, profileImage: Image("post1"), commentData: commentData, timeOfcomment: timeOfComment, commentLikesCount: commentLikesCount)
                     DispatchQueue.main.async {
                         post.postComments.append(comment)
                     }
                   
                 }
             }
         }
     }

}
extension Image{

    func fromURL(url: String) -> Self{
        if let data = try? Data(contentsOf: URL(string: url)!){
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self
        .resizable()
    }
}
