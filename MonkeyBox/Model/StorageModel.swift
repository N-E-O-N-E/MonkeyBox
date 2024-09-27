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
    var image: String
    
    @Relationship(inverse: \Item.storage)
    var items: [Item] = []

    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}

let storageImages = [
    
    "Storage-1",
    "Storage-2",
    "Storage-3",
    "Storage-4",
    "Storage-5",
    "Storage-6",
    "Storage-7",
    "Storage-8",
    "Storage-9",
]
