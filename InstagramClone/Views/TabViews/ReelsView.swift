//
//  ReelsView.swift
//  InstagramClone
//
//  Created by ashutosh on 09/07/21.
//

import SwiftUI

struct ReelsView: View {
    var body: some View {
        ZStack{
            Image("post6")
                .resizable()
                .ignoresSafeArea()
            VStack{
            HStack{
                Text("Reels").bold()
                    .foregroundColor(.white).font(.system(size: 25))
                    .padding(.leading)
                Spacer()
                Image(systemName: "camera")
                    .resizable()
                    .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            Spacer()

                HStack(alignment:.bottom){
                   
                    VStack(alignment:.leading){
                     //   Spacer()
                        HStack{
                        Image("post1")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.15, height: Screen.maxWidth*0.15, alignment: .center)
                            .clipShape(Circle())
                            Text("username").bold().foregroundColor(.white).font(.system(size: 14))
                            Text("•").bold().foregroundColor(.white).font(.system(size: 14))
                            Text("Follow").bold().foregroundColor(.white).font(.system(size: 14))
                        }
                        HStack{
                        Text("this is my caption captio")
                            .foregroundColor(.white).font(.system(size: 14))
                            .frame(width:Screen.maxWidth*0.3,height:10)
                            Text("more")
                                .foregroundColor(.gray).font(.system(size: 14))
                        }
                        Text("Song name").foregroundColor(.white).font(.system(size: 14))
                    }.padding(.leading)
                        .padding(.bottom)
                    Spacer()
                    VStack(spacing:Screen.maxHeight*0.025){
                        VStack{
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                            .foregroundColor(.white)
                        Text("100").foregroundColor(.white).font(.system(size: 14))
                        }
                        VStack{
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                            .foregroundColor(.white)
                            Text("100").foregroundColor(.white).font(.system(size: 14))
                        }
                        
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(22.5))
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.01, alignment: .center)
                            .foregroundColor(.white)
                        
                        Image("post1")
                            .resizable()
                            .frame(width: Screen.maxWidth*0.07, height: Screen.maxWidth*0.07, alignment: .center)
                            .cornerRadius(5)
                    }.padding(.trailing)
                        .padding(.bottom)
                }
                
                
            }.navigationBarHidden(true)
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}
