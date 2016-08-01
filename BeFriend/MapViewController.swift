//
//  MapViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/28/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var user: User!
    var places: [MKMapItem] = [MKMapItem]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(MapTableViewCell.self, forCellReuseIdentifier: "cell")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Location Manager Methods
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.requestLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
            mapView.setRegion(region, animated: false)
        }
        searchForPlacesOfInterest()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("\(error)")
    }
    
    // Zooming
    func zoomToUserLocationInMapView() {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func zoom(sender: AnyObject) {
        zoomToUserLocationInMapView()
    }
    
    // Other Methods
    func parseAddress(place: MKPlacemark) -> String {
        let firstSpace = (place.subThoroughfare != nil && place.thoroughfare != nil) ? " " : ""
        let comma = (place.subThoroughfare != nil || place.thoroughfare != nil) && (place.subAdministrativeArea != nil || place.administrativeArea != nil) ? ", " : ""
        let secondSpace = (place.subAdministrativeArea != nil && place.administrativeArea != nil) ? " " : ""
        let addressLine = String(format: "%@%@%@%@%@%@%@",
                                 place.subThoroughfare ?? "",
                                 firstSpace,
                                 place.thoroughfare ?? "",
                                 comma,
                                 place.locality ?? "",
                                 secondSpace,
                                 place.administrativeArea ?? "")
        return addressLine
    }

}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MapTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! MapTableViewCell
        let place = places[indexPath.row].placemark
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = parseAddress(place)
        
        return cell
    }
    
    func searchForPlacesOfInterest() {
        for interest in user.interests {
            let query = interest
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = query
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.startWithCompletionHandler({ reponse, _ in
                guard let response = reponse else {
                    return
                }
                self.places += response.mapItems
                self.tableView.reloadData()
                self.dropPins()
            })
        }
    }
    
}

class MapTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func dropPins() {
        mapView.removeAnnotations(mapView.annotations)
        
        for place in self.places {
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.placemark.coordinate
            annotation.title = place.placemark.name
            
            if let city = place.placemark.locality,
                let state = place.placemark.administrativeArea {
                annotation.subtitle = "\(city), \(state)"
            }
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
        pinView?.pinTintColor = UIColor.orangeColor()
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), forState: .Normal)
        button.addTarget(self, action: "getDirections", forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }

}






































