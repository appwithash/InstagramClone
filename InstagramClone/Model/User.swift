//
//  User.swift
//  InstagramClone
//
//  Created by ashutosh on 23/06/21.
//

import SwiftUI

class User : ObservableObject{
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var fullName : String = ""
    @Published var email : String = ""
    @Published var bio : String = ""
    @Published var profilePicture : Image = Image(systemName: "person")
    @Published var followingCount : Int = 0
    @Published var postCount : Int = 0
    @Published var followerCount : Int = 0
    @Published var userPostList : [Post] = []
    @Published var userTaggedPostList  : [Post] = []
    @Published var followerList  : [User] = []
    @Published var followingList  : [User] = []
    
}
