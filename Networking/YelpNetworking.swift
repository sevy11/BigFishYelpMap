//
//  YelpNetworking.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import Foundation
import CoreLocation


let kApiKey = "aqkKipj4Tpdt3xFQ7ml7xUAYuUVadu90NKbLSYLHFw58DaGCiLZ7l_D2NeTcm7bkAmrOHM0vKjSLvybIwokzZI6GWLTMSmnOL0fOulMHyXgzDRRT7vbHGiTstffiXnYx"
let clientID = "n46XV4RIvhfNm5Fex6CQaQ"
let baseURL = "https://api.yelp.com/v3"
let restaurantSearch = "/businesses/search?term=restaurants"

//GET https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972
//GET https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco

final class YelpNetworking {
    func getRestaurantsFor(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, success: @escaping (_ container: Container) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        let location = "&latitude=\(lattitude)&longitude=\(longitude)"
        guard let url = URL(string: "\(baseURL)\(restaurantSearch)\(location)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(kApiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                failure(err)
            }
            do {
                if let data = data {
                    let restaurants = try JSONDecoder().decode(Container.self, from: data)
                    //let restaurant =  try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(">>>>>", restaurants, #line, "<<<<<<<<<")
                    //                print("res: \(restaurant)")
                    success(restaurants)
                }
            } catch {
                failure(error)
            }
        }.resume()
    }
}
