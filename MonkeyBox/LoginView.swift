//
//  ContentView.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage("username") private var loginUser: String = ""
    @AppStorage("password") private var loginPassword: String = ""
    @AppStorage("loginState") private var loginState: Bool = false
    
    var body: some View {
       
            VStack(alignment:.leading) {
                
                
                Text("Anmeldung\n").font(.system(size: 40).bold())
                Text("Bitte Nutzernamen eingeben:")
                TextField(text: $loginUser) {
                    Text("Benutzername")
                }.textFieldStyle(.roundedBorder)
                
                Text("Bitte Passwort eingeben:")
                SecureField(text: $loginPassword) {
                    Text("Passwort")
                }.textFieldStyle(.roundedBorder)
                
                Text("\nKein Account? Jetzt Registrieren")
                    .font(.system(size: 10)).underline().foregroundStyle(.blue)
                
                
            }.padding(40)
        
        
        
            
            Button("Anmelden") {
                loginState = true
            }.frame(width: 120, height: 40)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        
        
    }
    


#Preview {
    LoginView()
}
