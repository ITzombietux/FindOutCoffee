//
//  CafeReviewListViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/16.
//

import UIKit

class CafeReviewListViewController: UIViewController {
    
    private var dataLoader: CafeListDataLoader!
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .systemBackground
        }
    }
    
    private var datasource: UICollectionViewDiffableDataSource<Int, CafeReview>!
    var navTitle: String?
    var kind: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .automatic
        title = navTitle
        
        configureBarButtonItem()
        configureCollectionView()
        
        fetchData()
    }
    
    private func configureCollectionView() {
    
        let layout = CafeReviewLayoutManager().createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = datasource
        collectionView.delegate = self
        
        let cafeReviewListsCellRegistration = UICollectionView.CellRegistration<CafeReviewCell, CafeReview> { cell, indexPath, cafeReview in
            
            cell.titleLabel.text = cafeReview.title
            cell.subtitleLabel.text = "#\(cafeReview.category) #\(cafeReview.feeling) #\(cafeReview.size) #\(cafeReview.isHot)"
            cell.nameLabel.text = "작성자: \(cafeReview.nickname)"
            let url = URL(string: cafeReview.thumbnail.first!)
            cell.imageView.kf.setImage(with: url)
        }
        
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionview, indexPath, model) -> UICollectionViewCell? in
            return collectionview.dequeueConfiguredReusableCell(using: cafeReviewListsCellRegistration, for: indexPath, item: model)
        })
    }
    
    private func configureBarButtonItem() {
        let closeButton = UIBarButtonItem(image: UIImage(named: "뒤로"), style: .done, target: self, action: #selector(closeAction))
        navigationItem.leftBarButtonItem  = closeButton
    }
    
    @objc private func closeAction() {
        dismiss(animated: false, completion: nil)
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CafeReview>()
        snapshot.appendSections([0])
        snapshot.appendItems(dataLoader.cafeReviews)
        
        datasource.apply(snapshot)
    }
    
    private func fetchData() {
        self.fetchDataLoader()
    }
    
    private func fetchDataLoader() {
        dataLoader = CafeListDataLoader(changeHandler: { cafeReviews in
            if cafeReviews.isEmpty {
                self.collectionView.setEmptyView(title: "아직 후기가 없어요 ㅠㅠ", message: "첫 후기의 주인공이 되어 주세요")
            } else {
                self.collectionView.restore()
                self.updateSnapshot()
            }
        })
        
        dataLoader.getCafeReviews(title: self.navTitle ?? "", kind: self.kind ?? "")
    }
}

//MARK: - 콜렉션뷰 delegate
extension CafeReviewListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reviewItem = dataLoader.cafeReviews[indexPath.row]
        let cafeReviewDetailC = CafeReviewDetailViewController()
        cafeReviewDetailC.navigationItem.title = reviewItem.title
        cafeReviewDetailC.cafeReviewDetail = reviewItem
        navigationController?.pushViewController(cafeReviewDetailC, animated: true)
    }
}
