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
    
    @State private var selectedItem: [Item] = []

    @Query var items: [Item]
    
    @State private var showItemEditSheet = false
    
    var body: some View {

        VStack {
            Text("MonkeyBox List").font(.system(size: 40)).bold()
                .padding(10)
            List{
                ForEach(items) { item in
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
                            
                        }
                    }.frame(height: 45)
                    .swipeActions{
                        Button("Löschen", role: .destructive) {
                            if let index = items.firstIndex(of: item) {
                                context.delete(items[index])
                            }
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showItemEditSheet){
                ItemDetailView(selectedItem: selectedItem.first)
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
