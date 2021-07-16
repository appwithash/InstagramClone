//
//  StoryGradient.swift
//  InstagramClone
//
//  Created by ashutosh on 09/04/21.
//

import SwiftUI

struct StoryGradient: View {
    var image:String
    var body: some View {
        ZStack{
        Circle()
            .stroke(LinearGradient(gradient: Gradient(colors: [Color("orange"),Color("cream"),Color("pink"),Color("purple"),Color("blue")]),startPoint: .bottom,endPoint: .topTrailing),lineWidth: 4)
            .frame(width: Screen.maxWidth*0.17, height: Screen.maxWidth*0.17, alignment: .center)
            Image(image).resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
               
              
        
                
            
        }.padding(.top,10)
    }
}

struct StoryGradient_Previews: PreviewProvider {
    static var previews: some View {
        StoryGradient(image: "post1")
    }
}
