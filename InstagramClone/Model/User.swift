//
//  User.swift
//  InstagramClone
//
//  Created by ashutosh on 23/06/21.
//

import SwiftUI
import FirebaseFirestore
import  Firebase
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
    @Published var isLoading : Bool = false
    @Published var status : Bool = false
    
    func logIn(){
        self.isLoading=true
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                self.status=true
                self.isLoading=false
            }
        }
    }
    
    func signIn(){
        let db = Firestore.firestore()
        self.isLoading=true
        db.collection("Users").addDocument(data: [
            "username" : self.username,
            "password" : self.password,
            "fullName" : self.fullName,
            "email" : self.email,
            "bio" : self.bio,
        ]) { error in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                self.isLoading=false
                
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                    }
                }
                
                self.status=true
                
            }
        }
    }
}
