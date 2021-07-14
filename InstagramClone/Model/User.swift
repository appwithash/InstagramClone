//
//  User.swift
//  InstagramClone
//
//  Created by ashutosh on 23/06/21.
//

import SwiftUI
import FirebaseFirestore
import  Firebase
import FirebaseStorage


class User : ObservableObject,Codable{
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var fullName : String = ""
    @Published var email : String = ""
    @Published var bio : String = ""
    @Published var website : String = ""
    @Published var profilePicture : Image = Image(systemName: "person")
    @Published var followingCount : Int = 0
    @Published var postCount : Int = 0
    @Published var followerCount : Int = 0
    @Published var userPostList : [Post] = [Post(username: "natasha", postImage: Image("image1"), location: "canada", profileImage: Image("post1"),isLiked:false, likesCount: 100),
                                            Post(username: "steverogers", postImage: Image("post2"), location: "america",profileImage: Image("post2"),isLiked:true, likesCount: 300),
                                            Post(username: "tonystark", postImage:  Image("post3"), location: "canada",profileImage: Image("post3"),isLiked:false, likesCount: 3000),
                                            Post(username: "thor", postImage:  Image("post4"), location: "canada", profileImage: Image("post4"), isLiked:true,likesCount: 100),
                                            Post(username: "hulk", postImage:  Image("post5"), location: "canada",profileImage: Image("post5"), isLiked:false,likesCount: 100),
                                            Post(username: "hawkaye", postImage:  Image("post6"), location: "canada",profileImage:Image("post6"), isLiked:true,likesCount: 100),]
    @Published var userTaggedPostList  : [Post] = []
    @Published var followerList  : [User] = []
    @Published var followingList  : [User] = []
    @Published var isLoading : Bool = false
    @Published var status : Bool = false
    @AppStorage("logStatus") var loginStatus = false
    @AppStorage("currentUser") var currentUserEmail = ""
    enum CodingKeys : CodingKey{
        case username,password,email,fullName,bio,website
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username,forKey: .username)
        try container.encode(password,forKey: .password)
        try container.encode(email,forKey: .email)
        try container.encode(bio,forKey: .bio)
        try container.encode(fullName,forKey: .fullName)
        try container.encode(website,forKey: .website)
    }
    init(){}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       username = try container.decode(String.self,forKey: .username)
        password = try container.decode(String.self,forKey: .password)
      email = try container.decode(String.self,forKey: .email)
      bio = try container.decode(String.self,forKey: .bio)
      fullName = try container.decode(String.self,forKey: .fullName)
       website = try container.decode(String.self,forKey: .website)
    }
    func logIn(){
        self.isLoading=true
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                self.setUp(currentUserEmail: self.email)
                self.status=true
                self.isLoading=false
                self.loginStatus=true
                self.currentUserEmail = self.email
            }
        }
    }
    
    func setUp(currentUserEmail : String){
        let db = Firestore.firestore()
        let dbRef = db.collection("Users").document(currentUserEmail)
        dbRef.getDocument(source: .server) { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
              
                self.email = document?.get("email") as! String
                self.password = document?.get("password") as! String
                self.fullName = document?.get("fullName") as! String
                self.username = document?.get("username") as! String
                self.website = document?.get("website") as! String
                self.bio = document?.get("bio") as! String
                
            }
            
        }
    }
    
    func updateData(){
        let db = Firestore.firestore()
        self.isLoading=true
        db.collection("Users").document(self.email).updateData([
            "username" : self.username,
            "password" : self.password,
            "fullName" : self.fullName,
            "email" : self.email,
            "bio" : self.bio,
            "website" : self.website
        ])
        setUp(currentUserEmail: self.email)
    }
    
    func signIn(){
        let db = Firestore.firestore()
        self.isLoading=true
        db.collection("Users").document(self.email).setData([
            "username" : self.username,
            "password" : self.password,
            "fullName" : self.fullName,
            "email" : self.email,
            "bio" : self.bio,
            "website" : self.website
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
                self.loginStatus=true
                self.currentUserEmail = self.email
                self.setUp(currentUserEmail: self.currentUserEmail)
            }
        }
    }
    
    func uploadPhoto(){
        let storage=Storage.storage()
        let storageRef = storage.reference()
        let data = Data()
        let imageRef = storageRef.child("images/image1")
        
//        let uploadPic = imageRef.putData(data, metadata: nil) { (metadata, error) in
//            if let error = error {
//              // 4 Uh-oh, an error occurred!
//              return
//            }
//        }
//        
//        reference.downloadURL(completion: { (url, error) in
//            if let error = error { return }
//            // 6
//          })
        
    }
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }

        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            // 4
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
    
}
