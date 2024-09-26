//
//  RegisterView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    
    @Environment(\.modelContext) private var context
    
    @AppStorage("loginState") private var loginState: Bool = false
//    @State private var loginActiv: Bool = false

    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var inputPasswordConfirm: String = ""
    @State private var showAlert = false

    var body: some View {
        
        Form {
            VStack(alignment:.leading) {
                
                Text("Create Account\n").font(.system(size: 40).bold())
                Text("Enter Username")
                TextField(text: $inputUsername) {
                    Text("Username")
                }
                .textFieldStyle(.roundedBorder)
                
                Text("Enter Password:")
                SecureField(text: $inputPassword) {
                    Text("Password")
                }
                .textFieldStyle(.roundedBorder)
                Text("Confirm Password:")
                SecureField(text: $inputPasswordConfirm) {
                    Text("Password")
                }
                .textFieldStyle(.roundedBorder)
                if inputPassword != inputPasswordConfirm {
                    Text("Password doesnt match")
                        .foregroundStyle(.red)
                }
            }
            
            Button("Create") {
                if inputPassword != inputPasswordConfirm && !inputUsername.isEmpty {
                    showAlert = true
                    
                } else {
                    let newUser = User(userName: inputUsername, password: inputPassword)
                    context.insert(newUser)
                    inputUsername = ""
                    inputPassword = ""
                    inputPasswordConfirm = ""
                    loginState = true
                }
            }.frame(width: 120, height: 40)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .alert("Attention you gave a wrong input.", isPresented: $showAlert){
                    Button("Ok"){
                        showAlert = false
                    }
                }
            
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return RegisterView()
        .modelContainer(container)
}
