//
//  CafePreviewScreenshotsViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/26.
//
import UIKit
import Kingfisher

class CafePreviewScreenshotsViewController: UIViewController {
    
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .systemBackground
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    var cafeReviewDetail: CafeReview? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
 
extension CafePreviewScreenshotsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeReviewDetail?.thumbnail.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as! ScreenshotCell
        
        let screenshots = self.cafeReviewDetail?.thumbnail[indexPath.row]
        let url = URL(string: screenshots ?? "")
        cell.imageView.kf.setImage(with: url)

        return cell
    }
}

extension CafePreviewScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
