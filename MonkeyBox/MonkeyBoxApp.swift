//
//  MonkeyBoxApp.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

@main
struct MonkeyBoxApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self, Item.self, Storage.self])
        }
    }
}
