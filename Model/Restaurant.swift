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
    
    private enum CodingKeys: String, CodingKey {
        case name
        case phone = "display_phone"
        case distance
        case image = "image_url"
        case isClosed = "is_closed"
        case location = "location"
    }
}

struct Location: Codable {
    var address1: String
    var display_address: [String]
}
//
//struct Container: Codable {
//    var total: Int
//    var businesses: [Restaurant]
//}
//
//struct Restaurant: Codable {
//    var name: String
//    var phone: String
//    var distance: Double
//    var image: String
//    var isClosed: Bool
//    var location: Location
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//        case phone = "display_phone"
//        case distance
//        case image = "image_url"
//        case isClosed = "is_closed"
//        case location = "location"
//    }
//}
//
//struct Location: Codable {
//    var address1: String
//    var display_address: [String]
//}



//>>>>> ["region": {
//    center =     {
//        latitude = "25.807515";
//        longitude = "-80.195403";
//    };
//}, "total": 3000, "businesses": <__NSArrayI 0x6000001d0160>(
//{
//    alias = "the-little-hen-miami-2";
//    categories =     (
//                {
//            alias = "breakfast_brunch";
//            title = "Breakfast & Brunch";
//        }
//    );
//    coordinates =     {
//        latitude = "25.809393";
//        longitude = "-80.19237699999999";
//    };
//    "display_phone" = "";
//    distance = "367.9185103480488";
//    id = "g-F5kChJsFopvG4YfYYKaw";
//    "image_url" = "https://s3-media4.fl.yelpcdn.com/bphoto/NB9rPD3hleIi0mcY19LRuw/o.jpg";
//    "is_closed" = 0;
//    location =     {
//        address1 = "3451 NE 1st Ave";
//        address2 = "";
//        address3 = "<null>";
//        city = Miami;
//        country = US;
//        "display_address" =         (
//            "3451 NE 1st Ave",
//            "Miami, FL 33137"
//        );
//        state = FL;
//        "zip_code" = 33137;
//    };
//    name = "The Little Hen";
//    phone = "";
//    price = "$$";
//    rating = "4.5";
//    "review_count" = 33;
//    transactions =     (
//        delivery,
//        pickup
//    );
//    url = "https://www.yelp.com/biz/the-little-hen-miami-2?adjust_creative=n46XV4RIvhfNm5Fex6CQaQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=n46XV4RIvhfNm5Fex6CQaQ";
//},
//{
