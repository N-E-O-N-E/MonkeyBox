//
//  RegisterView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct RegisterView: View {
    
    @AppStorage("loginState") private var loginState: Bool = false
    @State private var loginActiv: Bool = false
    
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var inputPasswordConfirm: String = ""

    var body: some View {
        
        Form {
            VStack(alignment:.leading) {
                
                Text("Registrierung\n").font(.system(size: 40).bold())
                Text("Nutzernamen vergeben:")
                TextField(text: $inputUsername) {
                    Text("Benutzername")
                }.textFieldStyle(.roundedBorder)
                
                Text("Passwort vergeben:")
                SecureField(text: $inputPassword) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                Text("Passwort bestätigen:")
                SecureField(text: $inputPasswordConfirm) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                
            }
            
            Button("Registrieren") {
                loginActiv = true
                
            }.frame(width: 120, height: 40)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
        }
        .navigationDestination(isPresented: $loginActiv) {
            LoginView()
        }
        
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RegisterView()
}
