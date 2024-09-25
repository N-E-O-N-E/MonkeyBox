//
//  SwiftUIView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    
    
    var body: some View {
        
            ZStack {
                Color(.brown)
                    .ignoresSafeArea()
                
                VStack {
                    Text("MonkeyBox")
                        .font(.system(size: 60)).bold()
                        .foregroundStyle(.white)
                        .shadow(radius: 4)
                    
                    Image("MonkeyBoxLogo")
                        .resizable()
                        .frame(width: 380, height: 380, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 4)
                    
                    Text("Inventory")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .shadow(radius: 4)
                }
            }
    }
}

#Preview {
    SplashView()
}
