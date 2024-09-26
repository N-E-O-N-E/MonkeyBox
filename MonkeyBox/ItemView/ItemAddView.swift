import SwiftUI
import SwiftData
struct ItemAddView: View {
    @Environment(\.modelContext) private var context
    @Query var storages: [Storage]
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var itemCategory: Storage?
    @State private var itemImage = ""
    @State private var itemDate = Date()
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
            Picker("Storage", selection: $selectedStorage) {
                ForEach(storages){ storage in
                    Text(storage.name).tag(storage as Storage)
                }
            }
            Button("Save Item") {
                if !itemImage.isEmpty && !itemName.isEmpty && itemCategory != nil {
                    let newItem = Item(name: itemName, descriptions: itemDescription,
                                       image: itemImage, storage: selectedStorage, date: itemDate)
                    context.insert(newItem)
                }
            }
        }.frame(height: 280)
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
            .presentationDetents([.fraction(0.8)])
        }
        Spacer()
    }
}
