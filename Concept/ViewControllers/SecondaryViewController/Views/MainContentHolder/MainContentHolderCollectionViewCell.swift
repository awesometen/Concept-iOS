//
//  MainContentHolderCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 30/11/20.
//

import UIKit

private extension CGFloat {
  static var kTopCategoryMenuCellHeight: CGFloat = 60
  static var kFilterCellHeight: CGFloat = 60
  static var kMainContentCellHeight: CGFloat = 472.0
}

protocol MainContentToViewDelegation {
  func onForcePullDown()
  func onForceDrawerUp()
}

protocol MainContentHolderCollectionCellInterface {
  var categories: [String] { get }
  var currentIndex: Int { get }
  var menuItems: MenuItemModel { get }
  var viewDelegate: MainContentToViewDelegation? { get }
}

struct MainContentHolderCollectionCellModel: MainContentHolderCollectionCellInterface{
  var categories: [String]
  var currentIndex: Int
  var menuItems: MenuItemModel
  var viewDelegate: MainContentToViewDelegation?
}

class MainContentHolderCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionHeightLayout: NSLayoutConstraint!
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: CurrentMenuCollectionViewCell.self)
      collectionView.registerReusableCell(cellType: MenuFiltersCollectionViewCell.self)
      collectionView.registerReusableCell(cellType: MenuContentCollectionViewCell.self)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
      collectionView.isScrollEnabled = true
      collectionView.isPagingEnabled = false
    }
  }
  
  //MARK: Private properties
  private var cellModel: MainContentHolderCollectionCellInterface?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.dataSource = nil
  }
  
  func configure(with cellModel: MainContentHolderCollectionCellInterface) {
    self.cellModel = cellModel
    collectionView.reloadData()
    collectionView.dataSource = self
    collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
  }
}

extension MainContentHolderCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cellModel = cellModel else { return UICollectionViewCell() }
    switch indexPath.row {
    case 0:
      let cell: CurrentMenuCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: CurrentMenuCollectionViewCellModel(categoryMenu: cellModel.categories, selectedItem: cellModel.categories[cellModel.currentIndex]))
      return cell
    case 1:
      guard let filters = cellModel.menuItems.filters else { return UICollectionViewCell() }
      let cell: MenuFiltersCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: MenuFiltersCollectionViewCellModel(availableFilter: filters))
      return cell
    case 2:
      guard let menuItems = cellModel.menuItems.menuItems else { return UICollectionViewCell() }
      let cell: MenuContentCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: MenuContentCollectionViewCellModel(menuItems: menuItems))
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
}

extension MainContentHolderCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row {
    case 0:
      return CGSize(width: UIScreen.main.bounds.width, height: 60)
    case 1:
      return CGSize(width: UIScreen.main.bounds.width, height: 60)
    case 2:
      guard let items = cellModel?.menuItems.menuItems?.count else { return .zero }
      let numberOfItems = CGFloat(items * 470)
      return CGSize(width: UIScreen.main.bounds.width, height: numberOfItems + 120)
    default:
      return CGSize.zero
    }
  }
}


extension MainContentHolderCollectionViewCell: UIScrollViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
    print(translation.y)
    if translation.y > 0 {
      guard scrollView.contentOffset.y <= 0 else { return }
      cellModel?.viewDelegate?.onForcePullDown()
    } else  {
      cellModel?.viewDelegate?.onForceDrawerUp()
    }
  }
}
