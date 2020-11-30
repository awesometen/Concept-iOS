//
//  PrimaryViewController.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import UIKit
import RxSwift

private let reuseIdentifier = "CouponsCollectionViewCell"


class PrimaryViewController: UIViewController {
  
  //MARK: IBOutlet private properties
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: CouponsCollectionViewCell.self)
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
      layout.scrollDirection = .horizontal
      collectionView.collectionViewLayout = layout
    }
  }
  @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
  
  //MARK: Public properties
  var presenter: PrimaryControllerViewToPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewHeight.constant = UIScreen.main.bounds.height / 2
    collectionView.isPagingEnabled = true
    view.backgroundColor = .red
    presenter?.fetchOffersList()
  }
}

extension PrimaryViewController: PrimaryControllerPresenterToView {
  func offerList(array: CouponListResponse) {
    guard let list = array.coupons else { return }
    let items = Observable.just(list)
    let _ = items.bind(to: collectionView.rx.items(cellIdentifier: reuseIdentifier, cellType: CouponsCollectionViewCell.self)) {
      (row, element, cell) in
      cell.configure(with: CouponsCollectionViewModel(title: element.title ?? "", subTitle: element.subTitle ?? "", imageUrl: element.thumbnail ?? ""))
    }
  }
  
  func onError(_ error: Error) {
    
  }
}
