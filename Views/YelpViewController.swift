//
//  ViewController.swift
//  BigFishYelp
//
//  Created by Michael Sevy on 6/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class YelpViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var restaurantView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isClosedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var restaurantViewToTopConstraint: NSLayoutConstraint!
    
    private let locationManager = CLLocationManager()
    private var localValue: CLLocationCoordinate2D? = nil
    private let yelpNetworking = YelpNetworking()
    private var restaurants = [Restaurant]()
    private var restaurant: Restaurant?
    private var isShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if localValue == nil {
            localValue = locValue
            yelpNetworking.getRestaurantsFor(lattitude: locValue.latitude, longitude: locValue.longitude, success: { [weak self] (container) in
                let sorted = container.restaurants.sorted(by: { $1.distance > $0.distance })
                self?.restaurants = sorted
                self?.restaurant = sorted.first!
                DispatchQueue.main.async {
                    self?.addPins(restaurants: sorted)
                    self?.setRestaurantView(restaurant: (self?.restaurant)!)
                }
            }, failure: { (error) in
                print("error: \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            })
        }
        if let localCoordinate = localValue {
            let center = CLLocationCoordinate2D(latitude: localCoordinate.latitude, longitude: localCoordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func onCallButtonTapped(_ sender: Any) {
        if let res = restaurant {
            print("make call at: \(res.phone)")

            let noForwardBarcket = res.phone.replacingOccurrences(of: "(", with: "")
            let noBackwareBrack = noForwardBarcket.replacingOccurrences(of: ")", with: "")
            let noSpace = noBackwareBrack.replacingOccurrences(of: " ", with: "")
            let noDash = noSpace.replacingOccurrences(of: "-", with: "")

            if let url = URL(string: "tel://\(noDash)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func setRestaurantView(restaurant: Restaurant) {
        if let url = URL(string: restaurant.image) {
            restaurantImageView.setImage(from: url)
        }
        nameLabel.text = restaurant.name
        isClosedLabel.text = restaurant.isClosed ? "CLOSED" : "OPEN"
        isClosedLabel.textColor = restaurant.isClosed ? .red : .green
        if restaurant.location.display_address[1].count > 0 {
            addressLabel.text = restaurant.location.display_address.first! + restaurant.location.display_address[1]
        } else {
            addressLabel.text = restaurant.location.display_address.first!
        }
        distanceLabel.text = String(format: "%.2f m", restaurant.distance)
    }
    
    func addPins(restaurants: [Restaurant]) {
        for res in restaurants {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: res.coordinates.latitude, longitude: res.coordinates.longitude)
            annotation.title = res.name
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let ann = self.mapView.selectedAnnotations[0] as MKAnnotation
        for res in restaurants {
            if ann.title == res.name {
                self.restaurant = res
                self.setRestaurantView(restaurant: res)
            }
        }
    }
}


