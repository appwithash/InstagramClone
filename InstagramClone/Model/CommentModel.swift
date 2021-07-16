//
//  CommentModel.swift
//  InstagramClone
//
//  Created by ashutosh on 15/07/21.
//

import SwiftUI
import Firebase
class Comment : Identifiable,ObservableObject{
    var id = UUID()
    var username = ""
    var profileImage : Image
    var commentData : String
    var replies : [Comment] = []
    var commentLikesCount : Int = 0
    var timeOfcomment = "2h"
    
    init(username:String,profileImage:Image,commentData : String) {
        self.username = username
        self.commentData=commentData
        self.profileImage=profileImage
    }
  
    init(username:String,profileImage:Image,commentData : String,timeOfcomment : String,commentLikesCount : Int) {
        self.username = username
        self.commentData=commentData
        self.profileImage=profileImage
        self.commentLikesCount=commentLikesCount
        self.timeOfcomment=timeOfcomment
    }
  
}
