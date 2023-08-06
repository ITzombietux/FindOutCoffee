//
//  GetAddress.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/18.
//

import Foundation
import CoreLocation

struct GetAddress {
    static func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        var pm =
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil) {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.administrativeArea) //
                                            print(pm.locality) //
                                            print(pm.location)
                                            print(pm.subLocality)//
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                        }
                                    })
    }
}
