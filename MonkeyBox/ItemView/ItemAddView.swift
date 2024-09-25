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
    @State private var itemImage = ""
    
    var body: some View {
        Form {
            Text("Add new Item:")
            TextField("Name", text: $itemName)
            
            Button("Save"){
                if itemImage != "" && itemName != "" {
                    let newItem = Storage(name: itemName, image: itemImage)
                    context.insert(newItem)
                }
            }
            
        }.frame(height: 190)
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(storageImages, id: \.self) { image in
                    
                    Button(action: {
                        itemImage = ""
                        itemImage = image
                    }) {
                        ZStack(alignment:.topTrailing) {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .border(.brown)
                                .shadow(radius: 2)
                                
                            
                            if image == itemImage {
                                let selected = true
  
                                Circle()
                                    .fill(.white)
                                    .frame(width: 30, height: 30)
                                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                                    .padding(5)
                                    .foregroundStyle(selected ? .pink : .black)
                                    .scaleEffect(1.5)
                            }
                        }
                    }.padding(8)
                }
            }.padding(10)
            .presentationDetents([.fraction(0.6)])
        }
        //Text("\(selectedImage)").font(.callout)
        Spacer()
    }
}

#Preview {
    ItemAddView()
}
