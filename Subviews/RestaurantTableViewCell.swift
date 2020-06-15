//
//  RestaurantTableViewCell.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var isClosedLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var callButton: UIButton!
    var phoneCallClosure: ((_ phoneNumber: String) -> Void)?
    var cellRestaurant: Restaurant?
    
    func configure(restaurant: Restaurant, phoneCall: (() -> Void)?) {
//        guard let closure = phoneCall else { return }
//        closure()

        if let url = URL(string: restaurant.image) {
            restaurantImageView.setImage(from: url)
        }
        nameLabel.text = restaurant.name
        isClosedLabel.text = restaurant.isClosed ? "CLOSED" : "OPEN"
        isClosedLabel.textColor = restaurant.isClosed ? .red : .green
        addressLabel.text = restaurant.location.display_address.first!
        distanceLabel.text = String(format: "\(restaurant.distance)meters")
        self.cellRestaurant = restaurant
    }
    
    
    @IBAction func onCallButtonTapped(_ sender: UIButton) {
        guard let closure = phoneCallClosure else { return }
        closure(self.cellRestaurant?.phone ?? "")
    }
}
