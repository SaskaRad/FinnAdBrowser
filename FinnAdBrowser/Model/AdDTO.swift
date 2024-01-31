//
//  AdDTO.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 29/01/2024.
//

import Foundation

struct AdDTO: Codable {
    var items: [AdItemsContainer]
}

struct AdItemsContainer: Codable {
    var description: String?
    var id: String
    var url: String?
    var adType: String
    var location: String?
    var type: String?
    var price: Price?
    var image: AdImage?
    var score: Double?
    var version: String?
    var favourite: Favourite?
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case description, id, url, location, type, price, image, score, version, favourite
        case adType = "ad-type"
    }
}

extension AdItemsContainer: Identifiable {
    var identity: String {
        self.id
    }
}

struct Price: Codable {
    var value: Int?
    var total: Int?
}

struct AdImage: Codable {
    var url: String
    var height: Int?
    var width: Int?
    var type: String?
    var scalable: Bool?
    
    var fullImageUrl: String {
        return "https://images.finncdn.no/dynamic/480x360c/\(url)"
    }
}

struct Favourite: Codable {
    var itemId: String?
    var itemType: String?
}

struct AdType {
    let name: String
    var systemImageName: String {
        switch name.uppercased() {
        case "REALESTATE": return "house"
        case "CAR": return "car"
        case "BAP": return "sofa"
        case "B2B": return "bus"
        default: return "questionmark"
        }
    }
}
