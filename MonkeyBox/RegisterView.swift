//
//  RegisterView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct RegisterView: View {
    @AppStorage("username") private var loginUser: String = ""
    @AppStorage("password") private var loginPassword: String = ""
    @AppStorage("loginState") private var loginState: Bool = false
    
    var body: some View {
        
        Form {
            VStack(alignment:.leading) {
                
                
                Text("Registrierung\n").font(.system(size: 40).bold())
                Text("Nutzernamen vergeben:")
                TextField(text: $loginUser) {
                    Text("Benutzername")
                }.textFieldStyle(.roundedBorder)
                
                Text("Passwort vergeben:")
                SecureField(text: $loginPassword) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                Text("Passwort bestätigen:")
                SecureField(text: $loginPassword) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                
   
            }.padding(10)
            
            Button("Du hast schon einen Account? Hier anmelden:") {
                
                
            }.font(.caption)
            
            
            Button("Registrieren") {
                loginState = true
            }.frame(width: 120, height: 40)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        
        
        
        
        
    }
}


#Preview {
    RegisterView()
}
