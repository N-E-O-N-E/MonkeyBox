//
//  StorageModel.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import Foundation
import SwiftData

@Model
class Storage: Identifiable{
    var id: UUID = UUID()
    var name: String
    var descriptions: String
    var image: String
    
    init(name: String, descriptions: String, image: String) {
        self.name = name
        self.descriptions = descriptions
        self.image = image
    }
    
}
