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
    @State private var selectedImage = ""
    
    var body: some View {
        Form {
            Text("Add new Room:")
            TextField("Name", text: $storageName)
            
            Button("Save"){
                if selectedImage != "" && storageName != "" {
                    let newStorageRoom = Storage(name: storageName, image: selectedImage)
                    context.insert(newStorageRoom)
                }
            }
            
        }.frame(height: 190)
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(storageImages, id: \.self) { image in
                    
                    Button(action: {
                        selectedImage = ""
                        selectedImage = image
                    }) {
                        ZStack(alignment:.topTrailing) {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .border(.brown)
                                .shadow(radius: 2)
                                
                            
                            if image == selectedImage {
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
    HomeAddView()
}
