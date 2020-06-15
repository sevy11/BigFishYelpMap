//
//  YelpViewModel.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import Foundation
import CoreLocation
import Combine


//class YelpViewModel: ObservableObject {
//    enum State {
//        case isLoading
////        case failed(Error)
//        case loaded([Restaurant]?)
//    }
//    
//    let yelpNetworking = YelpNetworking()
//    @Published private(set) var restaurants = State.loaded([Restaurant]?)
//    @Published private(set) var state = State.isLoading
////    @Published private(set) var failed = State.failed(Error())
//    var error: Error?
//    
//    func getRestaurantsAt(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        
//        yelpNetworking.getRestaurantsFor(lattitude: lattitude, longitude: longitude, success: { [weak self] (container) in
//        
//            print("send restaurants to view: \(container)")
//            //images.sorted(by: { $0.fileID > $1.fileID })
//
//            let sorted = container.restaurants.sorted(by: { $0.distance > $1.distance })
//            self?.restaurants = State.loaded(sorted)
//        }) { (error) in
//            self.error = error
//            print("error: \(error.localizedDescription)")
//        }
//    }
//}
