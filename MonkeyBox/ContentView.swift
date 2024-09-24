//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Milan Kadri on 24.09.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    @State private var isActive: Bool = false
    var body: some View {
        NavigationStack {
            SplashView()
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
        .modelContainer(for: [
            User.self,
            Item.self,
            Storage.self
        ]
        )
        
    }
}
    

#Preview {
    ContentView()
}
