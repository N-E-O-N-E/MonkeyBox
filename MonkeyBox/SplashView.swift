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
            
            Color(hue: 0.1, saturation: 0.4, brightness: 0.6)
                .ignoresSafeArea()
            
            VStack {
                Text("KongTainer")
                    .font(.system(size: 60)).bold()
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                
                Image("Kongtainer")
                    .resizable()
                    .frame(width: 380, height: 380, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                    .opacity(0.9)
                    .shadow(radius: 3)
                
                Text("\n...my king container")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .shadow(radius: 1)
                
                
            }
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return SplashView()
        .modelContainer(container)
}
