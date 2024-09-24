//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("loginState") private var loginState: Bool = false
    @State private var loginActiv: Bool = false
    @State private var registerActiv: Bool = false
    
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    
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
                loginActiv = true
                loginState = true
                
            }.frame(width: 130, height: 50)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button("Registrieren") {
                registerActiv = true
                
            }.frame(width: 120, height: 30)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .navigationDestination(isPresented: $loginActiv) {
            HomeView()
        }
        .navigationDestination(isPresented: $registerActiv) {
            RegisterView()
        }
        
        .navigationBarBackButtonHidden()
    }
}



#Preview {
    LoginView()
}
