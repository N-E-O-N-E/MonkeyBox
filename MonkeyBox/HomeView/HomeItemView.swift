import SwiftUI
import SwiftData

struct HomeItemView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var showItemDetailSheet = false
    
    var storage: Storage
    var selectedItem: Item?
    
    @Query var items: [Item]
    
    var body: some View {
        
        VStack {
            Text("Storage List").font(.system(size: 40)).bold()
                .padding(10)
            List{
                ForEach(items.filter({ $0.storage == storage.self })) { item in
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
                    }.onTapGesture {
                        showItemDetailSheet = true
                    }
                    .sheet(isPresented: $showItemDetailSheet){
                        ItemDetailView(selectedItem: item)
                    }
                    .frame(height: 45)
                    .swipeActions{
                        Button("Löschen", role: .destructive) {
                            if let index = items.firstIndex(of: item) {
                                context.delete(items[index])
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
}
#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, configurations: configuration)
    let storage = Storage(name: "Test Room", image: "MonkeyBoxLogo")
    return HomeItemView(storage: storage)
        .modelContainer(container)
}
