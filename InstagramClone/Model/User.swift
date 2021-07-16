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
import FirebaseDatabase

class User : ObservableObject,Codable{
    
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var fullName : String = ""
    @Published var email : String = ""
    @Published var bio : String = ""
    @Published var website : String = ""
    @Published var profilePicture : Image = Image( "image1")
    @Published var followingCount : Int = 0
    @Published var postCount : Int = 0
    @Published var followerCount : Int = 0
    @Published var userPostList : [Post] = []
    @Published var userPostUrlList : [String]=[]
    @Published var userTaggedPostList  : [Post] = []
    @Published var followerList  : [User] = []
    @Published var followingList  : [User] = []
    @Published var isLoading : Bool = false
    @Published var isLoadingHomeScreen : Bool = false
    @Published var status : Bool = false
    @Published var userPostURLString = ""
    
    @Published var userHomeFeed : [Post] = [
                                            Post(username: "natasha", postImage: Image("image1"), location: "canada", profileImage: Image("post1"),isLiked:false, likesCount: 100),
                                            Post(username: "steverogers", postImage: Image("post2"), location: "america",profileImage: Image("post2"),isLiked:true, likesCount: 300),
                                            Post(username: "tonystark", postImage:  Image("post3"), location: "canada",profileImage: Image("post3"),isLiked:false, likesCount: 3000),
                                            Post(username: "thor", postImage:  Image("post4"), location: "canada", profileImage: Image("post4"), isLiked:true,likesCount: 100),
                                            Post(username: "hulk", postImage:  Image("post5"), location: "canada",profileImage: Image("post5"), isLiked:false,likesCount: 100),
                                            Post(username: "hawkaye", postImage:  Image("post6"), location: "canada",profileImage:Image("post6"), isLiked:true,likesCount: 100),
    ]
    @AppStorage("logStatus") var loginStatus = false
    @AppStorage("currentUser") var currentEmail = ""
   @AppStorage("count") var count=1
    
    
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
                self.isLoading=false
            }else{
                self.currentEmail = self.email
                self.status=true
                self.isLoading=false
                self.loginStatus=true

            }
        }
    }
    
    

    func setUserDetails(email : String){
        print(email)
        self.isLoadingHomeScreen=true
        let db = Firestore.firestore()
        let dbRef = db.collection("Users").document(email)
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
                      self.postSetUp()
                  }
              }
    }
    
    func updateData(){
        let db = Firestore.firestore()
        self.isLoading=true
        db.collection("Users").document(self.currentEmail).updateData([
            "username" : self.username,
            "password" : self.password,
            "fullName" : self.fullName,
            "email" : self.email,
            "bio" : self.bio,
            "website" : self.website
        ])
        
        setUserDetails(email: self.currentEmail)
        self.isLoading=false
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
                "website" : self.website,
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
                    self.currentEmail = self.email
                 
                }
            }
        }
    

    
     func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
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
    
    
    func addPostToFirebase(){
        let db = Firestore.firestore()
        let myPost = Post(username: self.username, postImage: Image(systemName: "person"), location: "Dehradun", profileImage: self.profilePicture, isLiked: false, likesCount: 0, postNumber: self.count)
        db.collection("Users/\(self.username)/myPostList").document("Post\(self.count)").setData([
            "username" : myPost.username,
            "location" : myPost.location,
            "postUrl" : self.userPostURLString,
            "isLiked" : myPost.isLiked,
            "likesCount" : myPost.likesCount,
            "postNumber" : self.count,
   
        ]){ error in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                self.isLoading=false
                self.count+=1
            }
          
    }
    }
    
    
    func create(for image: UIImage) {
      
        self.isLoading=true
        let imageRef = Storage.storage().reference().child("\(self.currentEmail)/myPostList/image\(count).jpg")
        self.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            let urlString = downloadURL.absoluteString
            self.userPostURLString = urlString
            self.addPostToFirebase()
           self.setUserDetails(email: self.currentEmail)
            print("image url: \(urlString)")
         
        }
    }
    
    func postSetUp(){
        self.userHomeFeed=[
            Post(username: "natasha", postImage: Image("image1"), location: "canada", profileImage: Image("post1"),isLiked:false, likesCount: 100, postNumber: 0),
            Post(username: "steverogers", postImage: Image("post2"), location: "america",profileImage: Image("post2"),isLiked:true, likesCount: 300, postNumber: 0),
            Post(username: "tonystark", postImage:  Image("post3"), location: "canada",profileImage: Image("post3"),isLiked:false, likesCount: 3000, postNumber: 0),
            Post(username: "thor", postImage:  Image("post4"), location: "canada", profileImage: Image("post4"), isLiked:true,likesCount: 100, postNumber: 0),
            Post(username: "hulk", postImage:  Image("post5"), location: "canada",profileImage: Image("post5"), isLiked:false,likesCount: 100, postNumber: 0),
            Post(username: "hawkaye", postImage:  Image("post6"), location: "canada",profileImage:Image("post6"), isLiked:true,likesCount: 100, postNumber: 0),
        ]
        self.userPostList=[]
        let db = Firestore.firestore()
        
       db.collection("Users/\(self.username)/myPostList").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                   print("ERROR IN GETTING DOCUMENT: \(err)")
            } else{
                var totalPosts=0
                for document in querySnapshot!.documents {
                           totalPosts+=1
                            print("FINDED DOCUMENT \(document.documentID) => \(document.data())")
                            let url=document.get("postUrl") as! String
                            let username = document.get("username") as! String
                            let isLiked = document.get("isLiked") as! Bool
                            let likesCount = document.get("likesCount") as! Int
                            let location = document.get("location") as! String
                            let postNumber = document.get("postNumber") as! Int
                    DispatchQueue.main.async {
                        self.userPostList.insert(Post(username: username, postImage:Image(systemName: "photo").fromURL(url: url), location: location, profileImage: self.profilePicture, isLiked: isLiked, likesCount: likesCount, postNumber: postNumber), at: 0)
                        self.userHomeFeed.insert(Post(username: username, postImage:Image(systemName: "photo").fromURL(url: url), location: location, profileImage: self.profilePicture, isLiked: isLiked, likesCount: likesCount,postNumber: postNumber), at: 0)
                        
                        
                    }
                    }
                self.isLoadingHomeScreen=false
                self.isLoading=false
                self.postCount=totalPosts
             
            }
            
        }
    }
}
