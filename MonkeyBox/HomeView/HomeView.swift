//
//  HomeView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query var storages: [Storage]
    
    @AppStorage("loginState") private var loginState: Bool = false
    
    @State private var loginActiv: Bool = false
    @State private var showAddSheet = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 16) {
                
                ForEach(storages) { item in
                    
                    VStack(alignment:.center) {
                        Button(action: {
                            // Aktion
                            
                        }) {
                            ZStack {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 140)
                                    .cornerRadius(10)
                            }
                        }.onLongPressGesture(minimumDuration: 2.0) {
                            
                        }
                        
                        Text(item.name)
                            .font(.callout)
                            .padding(.bottom, 6)
                    }
                    .frame(maxWidth: 180, maxHeight: 190)
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(15)
                    .padding(10)
                }
                
                VStack(alignment:.center) {
                    Button(action: {
                        showAddSheet = true
                    }) {
                        
                        ZStack(alignment:.center) {
                            Image("MonkeyBoxLogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 140)
                                .cornerRadius(10)
                                .blur(radius: 2)
                            ZStack {
                                Image(systemName: "plus.app.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 125))
                                    .opacity(0.9)
                                
                            }
                        }
                    }
                    .sheet(isPresented: $showAddSheet){
                        HomeAddView()
                    }
                    
                    Text("Hinzufügen")
                        .font(.callout)
                        .padding(.bottom, 6)
                }
                .frame(maxWidth: 180, maxHeight: 190)
                .background(Color.orange.opacity(0.3))
                .cornerRadius(15)
                .padding(10)
                
            }
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, configurations: configuration)
    return HomeView()
        .modelContainer(container)
}
