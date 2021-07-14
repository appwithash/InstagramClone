//
//  Postmodel.swift
//  InstagramClone
//
//  Created by ashutosh on 13/07/21.
//

import SwiftUI

class Post : Identifiable,ObservableObject{
    var id = UUID()
    var username : String = ""
    var postImage : Image = Image(systemName: "person")
    var location : String = ""
    var profileImage : Image = Image(systemName: "person")
    @Published var isLiked : Bool = false
   @Published var likesCount : Int = 0
    
    init(){}
    init(username : String,postImage:Image,location : String,profileImage:Image,isLiked:Bool,likesCount:Int) {
        self.username=username
        self.postImage=postImage
        self.location=location
        self.profileImage=profileImage
        self.isLiked=isLiked
        self.likesCount=likesCount
    }

}
