//
//  Modifiers.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
      .accentColor(Color.white)
      .padding()
  }
}

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}



struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .heavy, design: .rounded))
    }
}

struct scoreLabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 8, weight: .bold, design: .rounded))
    }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 8))
            .padding(.vertical, 10)
            .padding(.horizontal, 7)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorBlackTransparent")))
    }
}

struct ReelImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 100, idealWidth: 160, maxWidth: 160, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct IconImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 20, idealWidth: 40, maxWidth: 60, alignment: .center)
            .modifier(ShadowModifier())
    }
}


struct BetCapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .heavy, design: .rounded))
            .modifier(ShadowModifier())
            .background(
                Capsule().fill(LinearGradient(gradient: Gradient(colors: [Color("ColorYellowRMIT"), Color("ColorRedRMIT")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 80, height: 50, alignment: .center)
            )
    }
}

struct CasinoChipModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 70)
            .modifier(ShadowModifier())
    }
}
