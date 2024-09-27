import SwiftUI
import SwiftData

struct HomeItemEditView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Query var storages: [Storage]
    
    @State private var storageName = ""
    @State private var selectedImage = ""
    @State private var newStorageName = ""
    
    let selectedItem: Storage?
    @State var saveAlert: Bool = false
    
    
    var body: some View {
        Form {
            Text("Edit Room - \(selectedItem!.name)").font(.title2).bold()
            TextField("New name here...", text: $storageName)
            
            Button("Save Changes "){
                if !storageName.isEmpty {
                    selectedItem?.name = storageName
                    selectedItem?.image = selectedImage
                    dismiss()

                }else {
                    saveAlert = true
                }
            }.alert("Please enter new Name", isPresented: $saveAlert) {
                Button("OK"){
                    saveAlert = false
                }
            }
            
        }.multilineTextAlignment(.leading).frame(height: 210)
        
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
                            if image == selectedItem!.image {
                                let selected = true
                                Circle()
                                    .fill(.white)
                                    .frame(width: 30, height: 30)
                                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                                    .padding(5)
                                    .foregroundStyle(selected ? .gray : .black)
                                    .scaleEffect(1.5)
                            }
                        }
                    }.padding(8)
                }
            }.padding(10)
                .presentationDetents([.fraction(0.6)])
        }
        
        Spacer()
    }
}


