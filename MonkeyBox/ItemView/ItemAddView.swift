//
//  ItemAddView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//


import SwiftUI
import SwiftData

struct ItemAddView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var itemCategory: Storage?
    @State private var itemImage = ""
    @State private var itemDate = Date()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        Form {
            HStack{
                Text("Add Item ").font(.title).bold()
                Image(itemImage)
            }
            
            TextField("Name", text: $itemName)
            TextField("Description", text: $itemDescription)
            //Picker("Category", text: $itemCategory)
            
            Button("Save Item"){
                if itemImage != "" && itemName != "" {
                    
                    let newItem = Item(name: itemName, descriptions: itemDescription,
                                       image: itemImage, storage: itemCategory, date: Date())
                    context.insert(newItem)
                }
            }
            
        }.frame(height: 230)
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(itemImages, id: \.self) { image in
                    
                    Button(action: {
                        itemImage = ""
                        itemImage = image
                    }) {
                        ZStack {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 34, height: 34)
                                .border(.black)
                            
                            
                            
                            if image == itemImage {
                                let selected = true
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 28, height: 28)
                                
                                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                                    .padding(5)
                                    .foregroundStyle(selected ? .green : .black)
                                    .scaleEffect(1)
                            }
                        }
                    }.padding(8)
                }
            }
            .presentationDetents([.fraction(0.8)])
        }
        
        Spacer()
    }
}

#Preview {
    ItemAddView()
}
