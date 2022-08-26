//
//  LogoView.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

struct LogoView: View {
    var logoFileName: String
    
    var body: some View {
        Image(logoFileName)
            .resizable()
            .scaledToFit()
            .frame(minHeight: 130, idealHeight: 150, maxHeight: 170, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(logoFileName: "rmit-casino-welcome-logo")
    }
}
