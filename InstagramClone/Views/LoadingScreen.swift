//
//  LoadingScreen.swift
//  InstagramClone
//
//  Created by ashutosh on 24/06/21.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack{
            Color.black.opacity(0.2).ignoresSafeArea()
            ProgressView().padding(20).background(Color.white).cornerRadius(10)
        }.frame(width: Screen.maxWidth, height: Screen.maxHeight, alignment: .center)
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
