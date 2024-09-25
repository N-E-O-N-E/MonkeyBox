//
//  ItemModel.swift
//  MonkeyBox
//
//  Created by Markus Wirtz on 23.09.24.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable{
    var id: UUID = UUID()
    var name: String
    var descriptions: String?
    var image: String
    var storage: Storage?
        
    init (name: String, descriptions: String? = nil, image: String, storage: Storage? = nil){
        self.name = name
        self.descriptions = descriptions
        self.image = image
        self.storage = storage
    }
}

let itemImages: [String] = [
    "Datei_1",
    "Datei_2",
    "Datei_3",
    "Datei_4",
    "Datei_5",
    "Datei_6",
    "Datei_7",
    "Datei_8",
    "Datei_9",
    "Datei_10",
    "Datei_11",
    "Datei_12",
    "Datei_13",
    "Datei_14",
    "Datei_15",
    "Datei_16",
    "Datei_17",
    "Datei_18",
    "Datei_19",
    "Datei_20",
    "Datei_21",
    "Datei_22",
    "Datei_23",
    "Datei_24",
    "Datei_25",
    "Datei_26",
    "Datei_27",
    "Datei_28",
    "Datei_29",
    "Datei_30",
    "Datei_31",
    "Datei_32",
    "Datei_33",
    "Datei_34",
    "Datei_35",
    "Datei_36",
    "Datei_37",
    "Datei_38",
    "Datei_39",
    "Datei_40",
    "Datei_41",
    "Datei_42",
    "Datei_43",
    "Datei_44",
    "Datei_45",
    "Datei_46",
    "Datei_47",
    "Datei_48",
    "Datei_49",
    "Datei_50",
    "Datei_51",
    "Datei_52",
    "Datei_53",
    "Datei_54",
    "Datei_55",
    "Datei_56",
    "Datei_57",
    "Datei_58",
    "Datei_59",
    "Datei_60",
    "Datei_61",
    "Datei_62",
    "Datei_63",
    "Datei_64",
    "Datei_65",
    "Datei_66",
    "Datei_67",
    "Datei_68",
    "Datei_69",
    "Datei_70",
    "Datei_71",
    "Datei_72",
    "Datei_73",
    "Datei_74",
    "Datei_75",
    "Datei_76",
    "Datei_77",
    "Datei_78",
    "Datei_79"
]
    
