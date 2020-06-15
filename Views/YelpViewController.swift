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
import Combine


class YelpViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableViewToMapConstraint: NSLayoutConstraint!
    
    private let locationManager = CLLocationManager()
    private var localValue: CLLocationCoordinate2D? = nil
    private let yelpNetworking = YelpNetworking()
    private var restaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        setupTableView()
        
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
                let sorted = container.restaurants.sorted(by: { $0.distance > $1.distance })
                self?.restaurants = sorted
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.alpha = 1
                    self?.tableViewToMapConstraint.constant = -250
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400.0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RestaurantCell")

        let headerView = UIView(frame: CGRect(x: 8, y: 8, width: tableView.frame.size.width, height: 50))
        let searchResultsLabel = UILabel()
        searchResultsLabel.text = "Saerch Result: \(self.restaurants.count)"
        headerView.addSubview(searchResultsLabel)
        tableView.tableHeaderView = headerView
        

        tableViewToMapConstraint.constant = 0
        tableView.alpha = 0
    }
    
    
    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RestaurantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }
//        guard let cell: RestaurantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantTableViewCell else { return UITableViewCell() }
        let restaurant = self.restaurants[indexPath.row]
        cell.configure(restaurant: restaurant) {
            print("make call from here")
        }
        return cell
    }

}


