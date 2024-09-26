import SwiftUI
import SwiftData
struct ItemAddView: View {
    @Environment(\.modelContext) private var context
    @Query var storages: [Storage]
    
    
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var itemImage = "Datei_1"
    @State private var itemDate = Date()
    @State private var itemQuantity = 1
    @State private var selectedStorage: Storage?
    let columns = [
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
                    .resizable()
                    .frame(width: 36, height: 36)
            }.frame(height: 40)
            TextField("Name", text: $itemName)
            TextField("Description", text: $itemDescription)
            
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
            
            Text("Anzahl: \(itemQuantity)")
            
            
            Picker("Storage", selection: $selectedStorage) {
                if !storages.isEmpty {
                    ForEach(storages){ storage in
                        Text(storage.name).tag(storage)
                    }
                }
            }
            Button("Save Item") {
                if !itemImage.isEmpty && !itemName.isEmpty && selectedStorage != nil {
                    let newItem = Item(name: itemName, descriptions: itemDescription,
                                       image: itemImage, storage: selectedStorage, date: itemDate, quantity: itemQuantity)
                    context.insert(newItem)
                }
            }
        }.frame(height: 440)
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
                                .frame(width: 64, height: 64)
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
            .presentationDetents([.fraction(1.0)])
        }
        Spacer()
    }
}
