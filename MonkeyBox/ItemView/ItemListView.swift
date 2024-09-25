//
//  ItemListView.swift
//  MonkeyBox
//
//  Created by Affiger Milan on 23.09.24.
//
import SwiftData
import SwiftUI

struct ItemListView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var items: [Item] = [
        .init(name: "Test1", image: "Datei_10"),
        .init(name: "Test2", image: "Datei_11")
    ]
    
    
    var body: some View {

        
            List{
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        HStack{
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 34)
                            Text(item.name)
                                .font(.headline)
                        }
                    }
                    .swipeActions{
                        Button(role: .destructive, action: {items.removeAll(where: {$0.id == item.id})}, label: {Text("Entfernen")})
                        
                    }
                }
        }
    }
    
}

#Preview {
    ItemListView()
}
