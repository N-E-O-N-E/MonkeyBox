//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    @Query var registeredUsers: [User]
    
    @AppStorage("loginState") private var loginState: Bool = false
    
    @State private var registerActiv: Bool = false
    @State private var showAlert = false
    
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var accountValid = false
    
    var body: some View {
        
        Form {
            VStack(alignment:.leading) {
                
                Text("Anmeldung\n").font(.system(size: 40).bold())
                Text("Bitte Nutzernamen eingeben:")
                TextField(text: $inputUsername) {
                    Text("Benutzername")
                }.textFieldStyle(.roundedBorder)
                
                Text("Bitte Passwort eingeben:")
                SecureField(text: $inputPassword) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                
            }
            
            Button("Anmelden") {
                loginCheck()
               
                
            }
            .frame(width: 130, height: 50)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .alert("Attention you gave a wrong input.", isPresented: $showAlert){
                Button("Ok"){
                    showAlert = false
                }
                
            }
            Button("Registrieren") {
                registerActiv = true
                
            }.frame(width: 120, height: 30)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            .navigationDestination(isPresented: $loginState) {
                HomeView()
            }
            .navigationDestination(isPresented: $registerActiv) {
                RegisterView()
            }
            
            .navigationBarBackButtonHidden()
        }
    }
    func loginCheck() {
        
        let foundUser = registeredUsers.first(where: { $0.userName == inputUsername})
        if foundUser?.password == inputPassword{
            accountValid = true
            loginState = true
        } else {
            showAlert = true
        }
    }
}



#Preview {
    LoginView()
}
