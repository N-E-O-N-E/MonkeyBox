//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Milan Kadri on 24.09.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("loginState") private var loginState: Bool = false
    
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isActive = true
                    }
                }
                .navigationDestination(isPresented: $isActive) {
                    if loginState {
                        
                        TabView {
                            HomeView()
                                .tabItem {
                                    Label("Home", systemImage: "house.fill")
                                }
                            
                            ItemListView()
                                .tabItem {
                                    Label("Einträge", systemImage: "doc.fill")
                                }
                            
                            
                        }.navigationBarBackButtonHidden()
                        
                    } else {
                        LoginView()
                    }
                }
                
        }.modelContainer(for: [User.self, Item.self, Storage.self])
    }
}


#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, configurations: configuration)
    return ContentView()
        .modelContainer(container)
}
