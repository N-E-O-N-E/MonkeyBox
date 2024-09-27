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

    @State private var selectedTab: Int = 1
    @State private var isActive: Bool = false

    var body: some View {

        if !isActive {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isActive = true
                    }
                }
        } else {
            if loginState {
                TabView(selection: $selectedTab) {
                
                        HomeView()
                    .tabItem {
                        Label("Storages", systemImage: "house.fill")
                    }
                    .tag(1)
                    NavigationStack{
                        ItemListView()
                    }
                        .tabItem {
                            Label("Items", systemImage: "doc.fill")
                        }
                        .tag(2)

                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        .tag(3)
                }
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
    }
}


#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return ContentView()
        .modelContainer(container)
}
