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
                        }
                        
                        Text(item.name)
                            .font(.callout)
                            .padding(5)
                    }
                    .frame(maxWidth: 180, maxHeight: 190)
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(15)
                    .padding(10)

                    
                }
      
                VStack(alignment:.center) {
                    Button(action: {
                        
//                        let newStorage: Storage = Storage(name: "Badroom", image: "MonkeyBoxLogo")
//                        context.insert(newStorage)
    
                    }) {
                        
                        
                        ZStack {
                            Image("MonkeyBoxLogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 140)
                                .cornerRadius(10)
                            
                            Image(systemName: "cross.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 120))
                                .opacity(0.7)
                            
                        }
                    }
                    
                    Text("Hinzufügen")
                        .font(.callout)
                        .padding(5)
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
