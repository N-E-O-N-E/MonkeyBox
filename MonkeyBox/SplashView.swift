//
//  SwiftUIView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
            .navigationDestination(isPresented: $isActive) {
                if loginState {
                    HomeView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
