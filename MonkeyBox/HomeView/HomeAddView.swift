//
//  HomeAddView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct HomeAddView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var storageName = ""

    var body: some View {
        Form{
            Text("Add new Room:")
            TextField("Name", text: $storageName)
            
        }
    }
}

#Preview {
    HomeAddView()
}
