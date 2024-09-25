//
//  SettingsView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 25.09.24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Abmelden") {
                loginState = false
            }
        }

    }
}

#Preview {
    SettingsView()
}
