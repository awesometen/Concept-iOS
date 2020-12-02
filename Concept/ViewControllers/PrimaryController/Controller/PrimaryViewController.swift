//
//  PrimaryViewController.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import UIKit
import RxSwift

private extension String {
  static let reuseIdentifier = "CouponsCollectionViewCell"
}

class PrimaryViewController: UIViewController {
  
  //MARK: IBOutlet private properties
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: CouponsCollectionViewCell.self)
      let layout = CollectionCustomLayout(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
      collectionView.collectionViewLayout = layout
      collectionView.isPagingEnabled = true
      collectionView.delegate = self
    }
  }
  @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
  @IBOutlet private weak var pageControl: UIPageControl! {
    didSet {
      pageControl.currentPageIndicatorTintColor = UIColor.white
    }
  }
  
  //MARK: Public properties
  var presenter: PrimaryControllerViewToPresenter?

  //MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewHeight.constant = UIScreen.main.bounds.height / 2
    view.backgroundColor = .darkGray
    presenter?.fetchOffersList()
  }
}

extension PrimaryViewController: PrimaryControllerPresenterToView {
  func offerList(array: CouponListResponse) {
    guard let list = array.coupons else { return }
    pageControl.numberOfPages = list.count
    let items = Observable.just(list)
    let _ = items.bind(to: collectionView.rx.items(cellIdentifier: .reuseIdentifier, cellType: CouponsCollectionViewCell.self)) {
      (row, element, cell) in
      cell.configure(with: CouponsCollectionViewModel(title: element.title ?? "", subTitle: element.subTitle ?? "", imageUrl: element.thumbnail ?? ""))
    }
  }
  
  func onError(_ error: Error) { }
}


extension PrimaryViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentPage = collectionView.contentOffset.x / UIScreen.main.bounds.width
    pageControl.currentPage = Int(currentPage)
  }
}
