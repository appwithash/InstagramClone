//
//  StoryModel.swift
//  InstagramClone
//
//  Created by ashutosh on 13/07/21.
//

import SwiftUI

struct Story : Identifiable{
    var id = UUID()
    var username : String
    let profilePicture : String
    let storyContent : String
}
