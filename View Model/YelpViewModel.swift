//
//  YelpViewModel.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import Foundation
import CoreLocation

class YelpViewModel {    
    let yelpNetworking = YelpNetworking()
    var restaurants = [Restaurant]()
    
    func getRestaurantsAt(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        yelpNetworking.getRestaurantsFor(lattitude: lattitude, longitude: longitude, success: { (container) in
            print("send restaurants to view: \(container)")
        }) { (error) in
            print("error: \(error.localizedDescription)")
        }
    }
}
