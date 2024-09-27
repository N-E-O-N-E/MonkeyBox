//
//  HomeView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Storage.name) var storages: [Storage]
    
    //    @AppStorage("loginState") private var loginState: Bool = false
    
    @State private var animationOn = false
    @State private var loginActiv: Bool = false
    @State private var showAddSheet = false
    @State private var showEditSheet = false
    
    @State private var selectedItems: [Storage] = []
    
    @State private var selectedStorage: Storage?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func delSelectedItems() {
        for item in selectedItems {
            if let index = storages.firstIndex(of: item) {
                context.delete(storages[index])
            }
        }
        selectedItems.removeAll()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("KongTainer").font(.system(size: 40)).bold()
                        .padding(10)
                    
                    Spacer()
                }
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(storages) { item in
                        Button(
                            action: {
                                if !animationOn {
                                    selectedStorage = item
                                } else {
                                    withAnimation {
                                        if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                            selectedItems.remove(at: index)
                                        } else {
                                            selectedItems.append(item)
                                        }
                                    }
                                }
                            },
                            label: {
                                VStack(alignment:.center) {
                                    ZStack {
                                        Image(item.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 140)
                                            .cornerRadius(10)
                                        
                                        if selectedItems.contains(where: { $0.id == item.id }) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.pink)
                                                .font(.system(size: 40))
                                                .background(Color.white.opacity(1.0))
                                                .clipShape(Circle())
                                                .padding(8)
                                        }
                                    }
                                    HStack {
                                        Text(item.name)
                                            .font(.callout)
                                            .foregroundStyle(.white)
                                    }.padding(.horizontal, 10)
                                }
                                .frame(maxWidth: 180, maxHeight: 190)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.systemGray3), Color(.black).opacity(0.7)]),startPoint: .top,endPoint: .bottom))
                                .shadow(radius: 1)
                                .cornerRadius(8)
                                .padding(10)
                                
                                .rotationEffect(Angle(degrees: animationOn ? -5 : 0))
                                .animation(animationOn ? Animation.easeInOut(duration: 0.2)
                                    .repeatForever(autoreverses: true) : .default, value: animationOn)
                                
                                .onLongPressGesture (minimumDuration: 1.0) {
                                    withAnimation {
                                        animationOn = true
                                    }
                                }
                            }
                        )
                        
                        
                        
                    }
                    
                    VStack(alignment:.center) {
                        Button(action: {
                            showAddSheet = true
                        }) {
                            
                            ZStack(alignment:.center) {
                                Image("Kongtainer")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 140)
                                    .cornerRadius(10)
                                    .blur(radius: 1)
                                ZStack {
                                    Image(systemName: "plus.app.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 125))
                                        .opacity(0.9)
                                }
                            }
                        }
                        .sheet(isPresented: $showAddSheet){
                            HomeAddView()
                        }
                        Text("NEW")
                            .font(.callout).foregroundStyle(.white)
                            .padding(.bottom, 6)
                    }
                    .frame(maxWidth: 180, maxHeight: 190)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.systemGray3), Color(.black).opacity(0.7)]),startPoint: .top,endPoint: .bottom))
                    .cornerRadius(8)
                    .padding(10)
                    .shadow(radius: 1)
                    
                    
                }
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        if !selectedItems.isEmpty {
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        selectedItems.removeAll()
                                        animationOn = false
                                    }
                                }) {
                                    HStack{
                                        Image(systemName: "xmark.square")
                                            .foregroundStyle(.black)
                                    }
                                }
                                
                                Button(action: {
                                    delSelectedItems()
                                    withAnimation {
                                        animationOn = false
                                    }
                                }) {
                                    HStack{
                                        Image(systemName: "trash")
                                            .foregroundStyle(.red)
                                        Text("Selected: \(selectedItems.count)").font(.callout)}
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        if selectedItems.count == 1{
                                            showEditSheet = true
                                            animationOn = false
                                        }
                                    }
                                }) {
                                    HStack{
                                        Image(systemName: "square.and.pencil")
                                            .foregroundStyle(.blue)
                                    }.sheet(isPresented: $showEditSheet){
                                        HomeItemEditView(selectedItem: selectedItems.first)
                                    }
                                }
                            }
                        }
                    }
                }
            }
//            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.black.opacity(0.3)]),startPoint: .top, endPoint: .bottom))
            
            .navigationDestination(item: $selectedStorage){
                HomeItemView(storage: $0)
            }
            
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return HomeView()
        .modelContainer(container)
}
