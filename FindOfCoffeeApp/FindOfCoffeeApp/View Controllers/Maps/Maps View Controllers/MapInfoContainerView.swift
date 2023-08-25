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
        let lon: Double = Double("\(pdblLongitude)")!
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
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationPermissionDeniedHandler() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive) { [weak self] _ in
            
        }
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true)
    }
    
    func checkUserDeviceLocationServiceAuthorization() {
        guard CLLocationManager.locationServicesEnabled() else {
            locationPermissionDeniedHandler()
            return
        }
            
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
            
        checkUserCurrentLocationAuthorization(authorizationStatus)
        NotificationCenter.default.post(name: Notification.Name.locationUpdate, object: nil)
    }
    
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
                
        case .denied, .restricted:
            locationPermissionDeniedHandler()
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.requestWhenInUseAuthorization()
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied:
            print("GPS 권한 요청 거부됨")
            locationPermissionDeniedHandler()
        default:
            print("GPS: Default")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
