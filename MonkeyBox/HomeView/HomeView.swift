//
//  HomeView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    @State private var loginActiv: Bool = false
    
    var body: some View {
        
        VStack {
            
            Button("Abmelden") {
                loginState = false
                loginActiv = true
            }.font(.subheadline)
            
        }
        .navigationDestination(isPresented: $loginActiv) { LoginView() }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
