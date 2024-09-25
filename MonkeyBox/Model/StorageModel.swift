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
    
    "MonkeyBoxLivingRoom",
    "MonkeyBoxKitchen",
    "MonkeyBoxBetroom",
    "MonkeyBoxChildroom",
    "MonkeyBoxBathroom",
    "MonkeyBoxOffice",
    "MonkeyBoxLoft",
    "MonkeyBoxBasement",
    "MonkeyBoxGarage",
    "MonkeyBoxOutdoor",
    "MonkeyBoxPanicRoom",
    "MonkeyBoxLogo"
]
