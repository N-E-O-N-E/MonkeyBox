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
    
    @State private var selectedTab: Int = 0
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isActive == false {
                    SplashView()
                }else {
                    if loginState {
                        TabView(selection: $selectedTab) {
                            HomeView()
                                .tabItem {
                                    Label("Storages", systemImage: "house.fill")
                                }
                                .tag(1)
                               
                            ItemListView()
                                .tabItem {
                                    Label("Items", systemImage: "doc.fill")
                                }
                                .tag(2)
                                
                            SettingsView()
                                .tabItem {
                                    Label("Settings", systemImage: "gearshape.fill")
                                }
                                .tag(3)
                                
                        }.navigationBarBackButtonHidden()
                        
                    } else {
                        LoginView()
                            .modelContainer(for: [User.self])
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isActive = true
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
