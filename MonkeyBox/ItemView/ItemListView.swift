//
//  ItemListView.swift
//  MonkeyBox
//
//  Created by Monkeys on 23.09.24.
//
import SwiftData
import SwiftUI

struct ItemListView: View {
    
    @Environment(\.modelContext) private var context
    @State private var searchText: String = ""
    
    @State private var selectedItem: Item?
    
    @Query(sort: \Item.name) var items: [Item] = []
    
    @State private var showItemEditSheet = false
    @State private var showItemDetailSheet = false
    
    
    var body: some View {
        
        VStack {
            Text("MonkeyBox List \(items.count) Items")
            
                .font(.system(size: 20)).bold()
                .padding(5)
            TextField("Search...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List{
                
                ForEach(items.filter { item in
                    searchText.isEmpty || item.name.lowercased().contains(searchText.lowercased())
                
                }) { item in
                    
                    VStack(alignment: .leading) {
                    HStack{
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("\(item.date.formatted(date: .abbreviated, time: .omitted))")
                                .font(.caption2)
                        }
                        Spacer()
                        
                        Text("\(item.quantity)")
                            .font(.subheadline)
                            .padding(10)
                        
                    }.onTapGesture {
                        selectedItem = item
                        showItemDetailSheet = true
                        
                    }
                }
                    .sheet(item: $selectedItem){ item in
                    ItemDetailView(selectedItem: item)
                    
                }
                .frame(height: 45)
                .swipeActions{
                    Button("Löschen", role: .destructive) {
                        if let index = items.firstIndex(of: item) {
                            context.delete(items[index])
                        }
                    }
                }
                    
                }
            }
            
        }
        
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                
                Button(action: {
                    showItemEditSheet = true
                    
                }) {
                    Text("Item ")
                    Image(systemName: "plus.app")
                        .foregroundStyle(.blue)
                    
                }
                .sheet(isPresented: $showItemEditSheet){
                    ItemAddView()
                }
            }
        }
    }
    
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return ItemListView()
        .modelContainer(container)
}

