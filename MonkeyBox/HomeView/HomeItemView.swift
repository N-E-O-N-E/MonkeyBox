import SwiftUI
import SwiftData
struct HomeItemView: View {
    @Environment(\.modelContext) private var context
    @State private var showItemDetailSheet = false
    var storage: Storage
    @Query var items: [Item]
    var body: some View {
        ScrollView {
            VStack {
                Text("\(storage.name) Inventory")
                    .font(.title).bold()
                    .padding()
                if items.isEmpty {
                    Text("No Room Items yet")
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(storage.items) { item in
                            VStack {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 34, height: 34)
                                Text(item.name)
                                    .font(.headline)
                                    .padding(.top, 5)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.5))
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle(storage.name)
    }
}
#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, configurations: configuration)
    let storage = Storage(name: "Test Room", image: "MonkeyBoxLogo")
    return HomeItemView(storage: storage)
        .modelContainer(container)
}
