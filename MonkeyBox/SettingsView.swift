import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("language") var appLanguage: String = "Deutsch"
    var language = ["English", "Deutsch", "Französisch"]
    @State private var notifications: Bool = true
    
    var body: some View {
 
        Form {
            Text("Settings").font(.system(size: 40)).bold()
            
            
//            Section(header: Text("Profile")) {
//                VStack(alignment:.leading) {
//                    TextField("Username", text: $savedUsername)
//                        .textFieldStyle(.roundedBorder)
//                    
//                    SecureField("Password", text: $savedPassword)
//                        .textFieldStyle(.roundedBorder)
                    
//                    Text("\nProfile-Image")
//                        .font(.headline)
                    
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(profileImages, id: \.self) { image in
//                                
//                                Button(action: {
//                                    savedProfileImage = image
//                                }) {
//                                    
//                                    
//                                    if image == savedProfileImage {
//                                        let selected = true
//                                        
//                                        Image(image)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 80, height: 80)
//                                            .cornerRadius(10)
//                                            .border(selected ? .red : .gray)
//                                            .padding(4)
//                                        
//                                        
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
            
            Section(header: Text("App-Settings")) {
                Toggle("Dark Mode", isOn: $darkMode)
                    .tint(.mint)
                
                Toggle("Notifications", isOn: $notifications)
                    .tint(.mint)
                
                Picker("Language", selection: $appLanguage) {
                    ForEach(language, id: \.self) { language in
                        Text(language)}
                }
            }
        }
        .scrollContentBackground(.hidden)
        .preferredColorScheme(darkMode ? .dark : .light)
        
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Storage.self, Item.self, User.self, configurations: configuration)
    return SettingsView()
        .modelContainer(container)
}
