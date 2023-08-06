//
//  CSReviewDetailController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/17.
//

import UIKit
import Kingfisher

class CSReviewDetailController: UIViewController {
    
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
    
    var cSReviewDetail: ConvenienceStore?
    
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

        collectionView.register(CSReviewCell.self, forCellWithReuseIdentifier: CSReviewCell.reuseIdentifier)
        collectionView.register(CSPreviewCell.self, forCellWithReuseIdentifier: CSPreviewCell.reuseIdentifier)
    }
}

extension CSReviewDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CSReviewCell.reuseIdentifier, for: indexPath) as! CSReviewCell
            
            cell.cSReviewDetail = cSReviewDetail
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CSPreviewCell.reuseIdentifier, for: indexPath) as! CSPreviewCell
            cell.horizontalController.cSReviewDetail = self.cSReviewDetail
            return cell
        }
    }
}

extension CSReviewDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let dummyCell = CSReviewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.cSReviewDetail = cSReviewDetail
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}
