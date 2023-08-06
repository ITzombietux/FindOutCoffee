//
//  MapsViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/07.
//

import UIKit
import NMapsMap

class MapsViewController: UIViewController {
    
    typealias CafeInfo = (key: (String, String, String), value: NetworkManager.Map)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userMapInfoView: UIView!
    
    private var mapView: NMFMapView!
    private var cafeInfos = [CafeInfo]()
    private var mapDataLoader: MapDataLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapDataLoader = MapDataLoader(changeHandler: { cafeInfos in
            self.cafeInfos = cafeInfos
            self.getCafeMarker()
        })
        
        mapDataLoader.fetch()
        
        mapView = NMFMapView(frame: view.frame)
        mapView.touchDelegate = self
        view.addSubview(mapView)
        view.addSubview(containerView)
        view.addSubview(userMapInfoView)
        
        mapView.logoAlign = .rightTop
        mapView.positionMode = .direction
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }

    private func getCafeMarker() {
        DispatchQueue.global(qos: .default).async {
            var cafeMarkers: [NMFMarker] = []

            self.cafeInfos.forEach { cafeInfo in
                let coord = NMGLatLng(lat: Double(cafeInfo.value.y) ?? 0.0, lng: Double(cafeInfo.value.x) ?? 0.0)
                
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: coord.lat, lng: coord.lng)
                
                let image = NMFOverlayImage(image: UIImage(named: cafeInfo.key.2)!)
                marker.iconImage = image
                marker.width = 58
                marker.height = 65
                
                cafeMarkers.append(marker)
            }
            
            DispatchQueue.main.async { [weak self] in
                //메인 스레드
                for cafeMarker in cafeMarkers {
                    cafeMarker.mapView = self?.mapView
                }
            }
        }
    }
}

//MARK:- 마커 탭
extension MapsViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
    }
}
