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
    
    
    var selectedItem: Item?
    
    @Query var storages: [Storage]
    
    @State private var itemQuantity = 1
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 160, height: 7)
                .padding()
        }
        
        List{
            
            HStack {
                Text(selectedItem!.name)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Image(selectedItem!.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
            }
            Text("Description: \(selectedItem!.descriptions ?? "")")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            Text("Item Added: \(selectedItem!.date.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
            
            Text("Quantity: \(selectedItem!.quantity)")
                .font(.subheadline)
            Button(action: {
                if selectedItem!.quantity > 1 {
                    selectedItem!.quantity -= 1
                }
            }){
                Text("-")
                    .frame(width: 75, height: 30)
                    .font(.title)
                    .background(Color(hue: 1.0, saturation: 0.6, brightness: 1.0))
                    .foregroundColor(Color.white)
                    .clipShape(.capsule)
            }
            
            Button(action: {
                if selectedItem!.quantity >= 1 {
                    selectedItem!.quantity += 1
                }
            }){
                Text("+")
                    .frame(width: 75, height: 28)
                    .font(.title)
                    .background(Color(hue: 0.4, saturation: 0.6, brightness: 0.7))
                    .foregroundColor(Color.white)
                    .clipShape(.capsule)
            }
            
        }
        .padding()
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    let testItem = Item(name: "Test Item", descriptions: "", image: "Datei_1", date: Date(), quantity: 1)
    return ItemDetailView(selectedItem: testItem)
        .modelContainer(container)
}
