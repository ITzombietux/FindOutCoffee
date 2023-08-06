//
//  ReviewListViewController.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/09.
//

import UIKit
import Kingfisher

class ReviewListViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case notice
        case cafe
        case taste
        case convenienceStore
        
        var sectionHeader: String {
            switch self {
            case .notice: return "공지사항"
            case .cafe: return "카페를 찾아서"
            case .taste: return "취향을 찾아서"
            case .convenienceStore: return "편커를 찾아서"
            }
        }
    }
    
    enum DataItem: Hashable {
        case notice(Notice)
        case cafe(Cafe)
        case taste(Taste)
        case convenienceStore(ConvenienceStore)
    }
    
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-header"
    }

    private var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: ReviewListViewModel!
    private var dataLoader = ReviewDataLoader()
    private var convenienceStoreDataLoader: ConvenienceStoreDataLoader!
    
    private var datasource: UICollectionViewDiffableDataSource<Section, DataItem>!
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .systemBackground
            collectionView.showsVerticalScrollIndicator = false
        }
    }

    private let writeImageView = UIImageView(image: UIImage(named: "작성"))
    private let storyboardName = "Review"
    private let noticeFullscreenControllerStorybardID = "NoticeFullscreenController"
    private let cafeReviewListViewControllerStoryboardID = "CafeReviewListViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "후기"
        
        setupWriteButton()
        configureCollectionView()
        fetchData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(writeReview))
        writeImageView.addGestureRecognizer(tap)
        writeImageView.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
        
    @objc func writeReview(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Review", bundle: .main)
        let writeReviewsVC = storyboard.instantiateViewController(identifier: "WriteReviewsViewController")
        
        if let writeReviewsVC = writeReviewsVC as? WriteReviewsViewController {
            writeReviewsVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(writeReviewsVC, animated: true)
        }
    }
    
    private func configureCollectionView() {
        let layout = LayoutManager().createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = datasource
        collectionView.delegate = self
        
        let noticeCellRegistration = UICollectionView.CellRegistration<NoticeCell, DataItem> { cell, indexPath, dataItem in
            if case .notice(let notice) = dataItem {
                cell.notice = notice
            }
        }
        
        let cafesCellRegistration = UICollectionView.CellRegistration<CafeCell, DataItem> { cell, indexPath, dataItem in
            if case .cafe(let cafe) = dataItem {
                cell.cafe = cafe
            }
        }
        
        let tasteCellRegistration = UICollectionView.CellRegistration<TasteCell, DataItem> { cell, indexPath, dataItem in
            if case .taste(let taste) = dataItem {
                cell.taste = taste
            }
        }
        
        let convenienceStoresCellRegistration = UICollectionView.CellRegistration<ConvenienceStoreCell, DataItem> { cell, indexPath, dataItem in
            
            if case .convenienceStore(let convenienceStore) = dataItem {
                cell.convenienceStore = convenienceStore
            }
        }
          
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else {
                fatalError("Unhandled section")
            }
            
            switch sectionKind {
            case .notice:
                return collectionView.dequeueConfiguredReusableCell(using: noticeCellRegistration, for: indexPath, item: model)
            case .cafe:
                return collectionView.dequeueConfiguredReusableCell(using: cafesCellRegistration, for: indexPath, item: model)
            case .taste:
                return collectionView.dequeueConfiguredReusableCell(using: tasteCellRegistration, for: indexPath, item: model)
            case .convenienceStore:
                return collectionView.dequeueConfiguredReusableCell(using: convenienceStoresCellRegistration, for: indexPath, item: model)
            }
        })
        
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration<SectionHeader> (elementKind: SupplementaryElementKind.sectionHeader) { header, kind, indexPath in
            guard let sectionKind = Section(rawValue: indexPath.section) else {
                fatalError("Unhandled section")
            }
        
            header.label.text = sectionKind.sectionHeader
            header.label.font = UIFont.boldSystemFont(ofSize: 25)
        }
        
        datasource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case SupplementaryElementKind.sectionHeader:
                return collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            default:
                return nil
            }
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DataItem>()
        snapshot.appendSections(Section.allCases)
        
        struct Grouping {
            let notices: [Notice]
            let cafes: [Cafe]
            let tastes: [Taste]
            let convenienceStores: [ConvenienceStore]
        }
        
        let grouping = Grouping(notices: dataLoader.notices, cafes: dataLoader.cafes, tastes: dataLoader.tastes, convenienceStores: convenienceStoreDataLoader.convienienceStores)
        
        snapshot.appendItems(grouping.notices.map { DataItem.notice($0) }, toSection: .notice)
        snapshot.appendItems(grouping.cafes.map { DataItem.cafe($0) }, toSection: .cafe)
        snapshot.appendItems(grouping.tastes.map { DataItem.taste($0) }, toSection: .taste)
        snapshot.appendItems(grouping.convenienceStores.map { DataItem.convenienceStore($0) }, toSection: .convenienceStore)
        datasource.apply(snapshot)
    }
    
    private func fetchData() {
        self.fetchDataLoader()
    }
    
    private func fetchDataLoader() {
        convenienceStoreDataLoader = ConvenienceStoreDataLoader(changeHandler: { convenienceStores in
            self.updateSnapshot()
        })
        
        convenienceStoreDataLoader.getConvienienceStores()
    }
}

//MARK: - 콜렉션뷰 delegate
extension ReviewListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else {
            fatalError("Unhandled section")
        }
        
        switch sectionKind {
        case .notice:
            showNotice(indexPath: indexPath)
        case .cafe:
            showCafeReviewLists(indexPath: indexPath)
        case .taste:
            showTasteReviewsLists(indexPath: indexPath)
        case .convenienceStore:
            showReviewDetail(indexPath: indexPath)
        }
    }
}

extension ReviewListViewController {
    private func setVC(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: identifier)
        return vc
    }
    
    private func showNotice(indexPath: IndexPath) {
        let noticeFullscreenC = setVC(identifier: noticeFullscreenControllerStorybardID)
        
        if let noticeFullscreenC = noticeFullscreenC as? NoticeFullscreenController {
            noticeFullscreenC.modalPresentationStyle = .fullScreen
            noticeFullscreenC.header = UIImage(named: dataLoader.notices[indexPath.row].thumbnail)
            noticeFullscreenC.text = dataLoader.notices[indexPath.row].text
            
            present(noticeFullscreenC, animated: true, completion: nil)
        }
    }
    
    private func showCafeReviewLists(indexPath: IndexPath) {
        let cafeReviewListVC = setVC(identifier: cafeReviewListViewControllerStoryboardID)
        
        if let cafeReviewListVC = cafeReviewListVC as? CafeReviewListViewController {
            let navController = UINavigationController(rootViewController: cafeReviewListVC)
            navController.modalPresentationStyle = .fullScreen
            
            cafeReviewListVC.navTitle = dataLoader.cafes[indexPath.row].title
            cafeReviewListVC.kind = "address"
            
            present(navController, animated: false) { }
        }
    }
    
    private func showTasteReviewsLists(indexPath: IndexPath) {
        let cafeReviewListVC = setVC(identifier: cafeReviewListViewControllerStoryboardID)
        
        if let cafeReviewListVC = cafeReviewListVC as? CafeReviewListViewController {
            let navController = UINavigationController(rootViewController: cafeReviewListVC)
            navController.modalPresentationStyle = .fullScreen
            cafeReviewListVC.navTitle = dataLoader.tastes[indexPath.row].title
            cafeReviewListVC.kind = "taste"
            
            present(navController, animated: false) { }
        }
    }
    
    private func showReviewDetail(indexPath: IndexPath) {
        let reviewItem = convenienceStoreDataLoader.convienienceStores[indexPath.row]
        let cSReviewDetailC = CSReviewDetailController()
        cSReviewDetailC.navigationItem.title = reviewItem.title
        cSReviewDetailC.cSReviewDetail = reviewItem
        navigationController?.pushViewController(cSReviewDetailC, animated: true)
    }
}

//MARK:- 작성하기 커스텀 버튼
extension ReviewListViewController {
    private func setupWriteButton() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(writeImageView)
        writeImageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        writeImageView.clipsToBounds = true
        writeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            writeImageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            writeImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            writeImageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            writeImageView.widthAnchor.constraint(equalTo: writeImageView.heightAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        Const.moveAndResizeImage(for: height, imageView: self.writeImageView)
    }
    
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.writeImageView.alpha = show ? 1.0 : 0.0
        }
    }
}
