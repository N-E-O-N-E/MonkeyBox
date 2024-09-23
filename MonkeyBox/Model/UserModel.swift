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
