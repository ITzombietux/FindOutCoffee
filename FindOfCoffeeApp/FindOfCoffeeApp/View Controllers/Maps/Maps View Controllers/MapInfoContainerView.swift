//
//  MapInfoContainerView.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/29.
//

import UIKit
import NMapsMap

class MapInfoContainerView: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var kmInfoLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
    }
    
    private func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil) {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            self.addressLabel.text = "\(pm.administrativeArea ?? "") \(pm.locality ?? "") \(pm.subLocality ?? "")"
                                        }
                                    })
    }
}

extension MapInfoContainerView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            getAddressFromLatLon(pdblLatitude: coordinate.latitude.description,
                                 withLongitude: coordinate.longitude.description)
        }
        
        locationManager.stopUpdatingLocation()
    }
}
