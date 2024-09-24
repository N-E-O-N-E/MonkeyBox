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
        }.frame(height: 150)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(storageImages, id: \.self) { image in
                        
                        
                        Button(action: {
                            selectedImage = ""
                            selectedImage = image
                            
                        }) {
                            ZStack {
                                
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                    
                                if image == selectedImage {
                                    let selected = true
                                    Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                                        .padding(5)
                                        .foregroundStyle(selected ? .white : .black)
                                        .offset(x: 60, y: -60)
                                        
                                }
                                    
                                    
                                
                            }
                            
                        }.padding(2)
                    }
                }
                .presentationDetents([.fraction(0.6)])
            }
       //Text("\(selectedImage)").font(.callout)
        Spacer()
    }
}


#Preview {
    HomeAddView()
}
