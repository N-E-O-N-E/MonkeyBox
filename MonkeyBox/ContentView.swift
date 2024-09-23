//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    
    var body: some View {
        
        
        
        if loginState {
            SplashView()
            HomeView()

            
        } else {
            SplashView()
            LoginView()
        }
    }
}


#Preview {
    ContentView()
}
