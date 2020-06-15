//
//  Restaurant.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import Foundation


struct Container: Codable {
    var total: Int
    var restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case total
        case restaurants = "businesses"
    }
}

struct Restaurant: Codable {
    var name: String
    var phone: String
    var distance: Double
    var image: String
    var isClosed: Bool
    var location: Location
    var coordinates: Coordinates
    
    private enum CodingKeys: String, CodingKey {
        case name
        case phone = "display_phone"
        case distance
        case image = "image_url"
        case isClosed = "is_closed"
        case location = "location"
        case coordinates = "coordinates"
    }
}

struct Location: Codable {
    var address1: String
    var display_address: [String]
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}
