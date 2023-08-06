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
        
        let pdblLatitude = String(getCurrentAddress().1)
        let withLongitude = String(getCurrentAddress().0)
        getAddressFromLatLon(pdblLatitude: pdblLatitude, withLongitude: withLongitude)
    }
    
    private func getCurrentAddress() -> (Double, Double) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
        
        let longitude = Double(locationManager.location?.coordinate.longitude ?? 0.0)
        let latitude = Double(locationManager.location?.coordinate.latitude ?? 0.0)
        
        return (longitude, latitude)
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
