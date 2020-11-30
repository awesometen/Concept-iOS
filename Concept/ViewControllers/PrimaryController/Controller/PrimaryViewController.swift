//
//  PrimaryViewController.swift
//  Concept
//
//  Created by Vijay Jayapal on 26/11/20.
//

import UIKit

private let reuseIdentifier = "CouponsCollectionViewCell"


class PrimaryViewController: UIViewController {
  
  //MARK: IBOutlet private properties
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.registerReusableCell(cellType: CouponsCollectionViewCell.self)
    }
  }
  @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
  
  //MARK: Private properties
  private var couponList: CouponListResponse?

  //MARK: Public properties
  var presenter: PrimaryControllerViewToPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.fetchOffersList()
    collectionViewHeight.constant = UIScreen.main.bounds.height / 2
    collectionView.reloadData()
    collectionView.isPagingEnabled = true
    view.backgroundColor = .red
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.reloadData()
  }
}

extension PrimaryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CouponsCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
    if let model = itemFor(indexPath: indexPath) {
      cell.configure(with: model)
    }
    return cell
  }
}

extension PrimaryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
  }
}


extension PrimaryViewController: PrimaryControllerPresenterToView {
  func offerList(array: CouponListResponse) {
    couponList = array
    collectionView.reloadData()
  }
  
  func onError(_ error: Error) {
    
  }
}

extension PrimaryViewController {
  func itemFor(indexPath: IndexPath) -> CouponsCollectionViewModel? {
    guard let model = couponList,
          let coupon = model.coupons?[indexPath.row],
          let title = coupon.title,
          let subTitle = coupon.subTitle,
          let thumbnail = coupon.thumbnail
    else { return nil }
    return CouponsCollectionViewModel(title: title, subTitle: subTitle, imageUrl: thumbnail)
  }
}
