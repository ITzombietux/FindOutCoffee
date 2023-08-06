//
//  MapListsViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/21.
//

import UIKit

class MapListsViewController: UIViewController {
    
    typealias CafeInfo = (key: (String, String, String), value: NetworkManager.Map)

    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isScrollEnabled = false
        }
    }
    
    private var mapListsCellRegistration: UICollectionView.CellRegistration<MapCell, CafeInfo>!
    
    var mapDataLoader: MapDataLoader!
    private var cafeInfos = [CafeInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapDataLoader = MapDataLoader(changeHandler: { cafeInfos in
            self.cafeInfos = cafeInfos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        mapDataLoader.fetch()
        
        configureCollectionView()
        fetchData()
    }
    
    private func configureCollectionView() {
        
        let layout = MapLayoutManager().createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        mapListsCellRegistration = UICollectionView.CellRegistration { cell, indexPath, map in
            cell.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.imageView.image = UIImage(named: map.key.0)
            cell.subtitleLabel.text = map.key.1
            cell.titleLabel.text = map.value.placeName
            cell.addressLabel.text = map.value.roadAddressName
        }
    }
    
    private func fetchData() {
        self.collectionView.reloadData()
    }
}

//MARK:- 콜렉션뷰 datasource
extension MapListsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let map = cafeInfos[indexPath.row]
    
        return collectionView.dequeueConfiguredReusableCell(using: mapListsCellRegistration, for: indexPath, item: map)
    }
}
//MARK: - 콜렉션뷰 delegate
extension MapListsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCafeReviewLists(indexPath: indexPath)
    }
}

extension MapListsViewController {
    private func showCafeReviewLists(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Review", bundle: .main)
        let cafeReviewListVC = storyboard.instantiateViewController(identifier: "CafeReviewListViewController")
        
        if let cafeReviewListVC = cafeReviewListVC as? CafeReviewListViewController {
            let navController = UINavigationController(rootViewController: cafeReviewListVC)
            navController.modalPresentationStyle = .fullScreen
            
            let title = mapDataLoader.cafeInfosResult[indexPath.row].key.0
            
            cafeReviewListVC.navTitle = title
            cafeReviewListVC.kind = "address"
            
            present(navController, animated: false) {
                
            }
        }
    }
}
