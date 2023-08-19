//
//  MapDataLoader.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/21.
//

import UIKit
import NMapsMap
import FirebaseDependency

class MapDataLoader {
    
    typealias CafeInfo = (key: (String, String, String), value: NetworkManager.Map)
    typealias Handler = ([CafeInfo]) -> Void
    var changeHandler: Handler
    
    private let availableCafes: [(String, String, String)] = [
        ("스타벅스", "세계에서 가장 큰 다국적 커피 전문점", "스타벅스마커"),
        ("이디야커피", "대한민국 매장수 1위 카페 프렌차이즈", "이디야커피마커"),
        ("요거프레소", "드렌디한 시즌별 디저트 시그니처 커피 요거트 아이스크림을 제공하는 프렌차이즈 디저트카페", "요거프레소마커"),
        ("투썸", "나만의 즐거움을 만날 수 있는 프리미엄 디저트 카페", "투썸마커"),
        ("탐앤탐스", "좋은 사람들이 만나 향기로운 커피와 맛있는 메뉴를", "탐앤탐스마커"),
        ("빽다방", "싸고, 크고, 맛있는 놀라운 가성비", "빽다방마커"),
        ("아마스빈", "당신을 사랑하는 버블티", "아마스빈마커"),
        ("커피베이", "드넓은 커피의 바다 위, 믿을 수 있는 친구와도 같은 커피 항해사", "커피베이마커"),
        ("메머드", "대용량의 커피 뿐만 아니라 감성을 전달하는 경쟁력", "메머드마커"),
        ("커피나무", "커피행 열차를 탈 준비를 하시죠", "커피나무마커"),
        ("더벤티", "합리적인 가격에 맛있는 한 잔", "더벤티마커"),
//        ("토프레소", "일상에서 즐기는 신선한 커피", "토프레소마커"),
        ("할리스", "의미 있는 작은 차이가 평범함과 특별함을 가르는 기준이 된다", "할리스마커"),
        ("커피에반하다", "합리적인 가격으로 커피문화의 대중화를 선도하고 있는 프랜차이즈 커피전문점 커피에반하다", "커피에반하다마커"),
        ("엔제리너스", "천사처럼 부드럽고 달콤한 정통 커피의 맛과 향", "커피에반하다마커"),
        ("메가커피", "더 크고, 더 맛있다!", "메가커피마커"),
        ("커피빈", "Coffee Bean & Tea Leaf", "커피빈마커"),
        ("공차", "Blended Happiness With Tea", "공차마커"),
        ("파스쿠찌", "이탈리안 초콜릿의 진한 맛", "파스쿠찌마커"),
//        ("셀렉토", "Select Your Americano", "셀렉토마커")
    ]
    
    private var cafeLists = [(String, String)]()
    
    private let pages = [1,2,3,4,5,6,7,8,9,10]
    
    private let locationManager = CLLocationManager()
    private let networkManager = NetworkManager()
    
    var mapsResult = [NetworkManager.Map]()
    
    var cafeInfosResult: [CafeInfo] = [] {
        didSet {
            changeHandler(cafeInfosResult)
        }
    }
    
    init(changeHandler: @escaping Handler) {
        self.changeHandler = changeHandler
    }
    
    private func getCurrentLocation() -> (Double, Double) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false

        let longitude = Double(locationManager.location?.coordinate.longitude ?? 0.0)
        let latitude = Double(locationManager.location?.coordinate.latitude ?? 0.0)
        
        return (longitude, latitude)
    }
    
    func fetch() {
        var allMapsResult = [NetworkManager.Map]()
        var cafeInfos = [CafeInfo]()
        let dispatchGroup = DispatchGroup()
        
        let x = getCurrentLocation().0
        let y = getCurrentLocation().1
        
        pages.forEach { page in
            dispatchGroup.enter()
            networkManager.fetchMapDocuments(page: page, x: x, y: y) { result in
                dispatchGroup.leave()
                switch result {
                case .failure(let error):
                print(error.localizedDescription)
                    
                case .success(let mapsResult):
                    print("--> #\(page)")
                    mapsResult.documents.forEach { map in
                        self.availableCafes.forEach { placeName in
                            if map.placeName.contains(placeName.0) {
                                allMapsResult.append(map)
                            }
                        }
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("update maps")
            self.mapsResult = self.removeDuplication(in: allMapsResult)
            
            self.mapsResult.forEach { mapResult in
                self.availableCafes.forEach { cafeInfo in
                    if mapResult.placeName.contains(cafeInfo.0) {
                        cafeInfos.append((cafeInfo, mapResult))
                    }
                }
            }
            
            self.cafeInfosResult = cafeInfos
            self.changeHandler(self.cafeInfosResult)
        }
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changeHandler = handler
    }
    
    private func removeDuplication(in array: [NetworkManager.Map]) -> [NetworkManager.Map] {
        let set = Set(array)
        let duplicationRemoveArray = Array(set)
        return duplicationRemoveArray
    }
}
