//
//  UserModel.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import Foundation
import SwiftData

@Model
class User: Identifiable{
    var id: UUID = UUID()
    var userName: String
    var password: String
    var profileImage: String?
    
    init(userName: String, password: String, profileImage: String? = nil) {
        self.userName = userName
        self.password = password
        self.profileImage = profileImage
    }
}

let userProfileImages = [
    "Kongtainer",
    "Datei_23",
    "Datei_45",
    "Datei_12",
    "Datei_3",
    "Datei_42",
    "Datei_62",
    "Datei_72",
    "Datei_56",
]
