//
//  CafeReviewDetailViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/26.
//

import UIKit
import Kingfisher

class CafeReviewDetailViewController: UIViewController {
    
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .systemBackground
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsVerticalScrollIndicator = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var cafeReviewDetail: CafeReview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.register(CoffeeReviewCell.self, forCellWithReuseIdentifier: CoffeeReviewCell.reuseIdentifier)
        collectionView.register(CafePreviewCell.self, forCellWithReuseIdentifier: CafePreviewCell.reuseIdentifier)
    }
}

extension CafeReviewDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeReviewCell.reuseIdentifier, for: indexPath) as! CoffeeReviewCell
    
            cell.cafeReviewDetail = cafeReviewDetail
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CafePreviewCell.reuseIdentifier, for: indexPath) as! CafePreviewCell
            cell.horizontalController.cafeReviewDetail = self.cafeReviewDetail
            return cell
        }
    }
}

extension CafeReviewDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let dummyCell = CoffeeReviewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.cafeReviewDetail = cafeReviewDetail
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}
