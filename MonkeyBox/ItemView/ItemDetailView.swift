//
//  ItemDetailView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    
    @Environment(\.modelContext) private var context
    @Query var storages: [Storage]
    @State private var itemQuantity = 1

    var item: Item
    
    var body: some View {
    
            Text(item.name)
            .font(.title)
            .fontWeight(.semibold)
            
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
        List{
            Text("Description:")
            
            Text("Added:")
                .font(.subheadline)
            Text(item.date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
            
            Text("Quantity: \(item.quantity)")
                .font(.subheadline)
            Button(action: {
                if itemQuantity > 1 {
                    itemQuantity -= 1
                }
            }){
                Text("-")
                    .frame(width: 15, height: 5)
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    
            }
            
            
            
            Button(action: {
                if itemQuantity >= 1 {
                    itemQuantity += 1
                }
            }){
                Text("+")
                    .frame(width: 15, height: 5)
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    
            }
         
            
            Spacer()
        }
        .padding()
        .navigationTitle("\(item.name) Details")
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    let testItem = Item(name: "Test Item", descriptions: "A detailed description", image: "Datei_1", date: Date(), quantity: 1)
    return ItemDetailView(item: testItem)
        .modelContainer(container)
}
