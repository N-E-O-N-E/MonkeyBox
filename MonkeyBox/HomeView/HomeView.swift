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
    @Query var storages: [Storage]
    
    //    @AppStorage("loginState") private var loginState: Bool = false
    
    @State private var animationOn = false
    @State private var loginActiv: Bool = false
    @State private var showAddSheet = false
    @State private var showEditSheet = false
    
    @State private var selectedItems: [Storage] = []
    
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
        ScrollView {
            HStack {
                Text("MonkeyBox").font(.system(size: 40)).bold()
                    .padding(10)
                
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(storages) { item in
                    
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
                                
                            Spacer()
                            NavigationLink(destination: HomeItemView(storage: item.self)){
                                Image(systemName: "arrowshape.right.circle.fill").tint(.black)
                            }.padding(5)
                        }.padding(.horizontal, 10)
                    }
                    .frame(maxWidth: 180, maxHeight: 190)
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(15)
                    .padding(10)
                    
                    .rotationEffect(Angle(degrees: animationOn ? -5 : 0))
                    .animation(animationOn ? Animation.easeInOut(duration: 0.2)
                        .repeatForever(autoreverses: true) : .default, value: animationOn)
                    
                    .onLongPressGesture (minimumDuration: 1.0) {
                        withAnimation {
                            animationOn = true
                        }
                    }
                    
                    .onTapGesture {
                        withAnimation {
                            if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                selectedItems.remove(at: index)
                            } else {
                                selectedItems.append(item)
                            }
                        }
                    }
                }
                
                VStack(alignment:.center) {
                    Button(action: {
                        showAddSheet = true
                    }) {
                        
                        ZStack(alignment:.center) {
                            Image("MonkeyBoxLogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 140)
                                .cornerRadius(10)
                                .blur(radius: 2)
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
                    Text("Hinzufügen")
                        .font(.callout)
                        .padding(.bottom, 6)
                }
                .frame(maxWidth: 180, maxHeight: 190)
                .background(Color.orange.opacity(0.3))
                .cornerRadius(15)
                .padding(10)
                
                
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
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return HomeView()
        .modelContainer(container)
}
