//
//  MenuContentCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol MenuContentCollectionViewCellInterface {
  var menuItems: [MenuItems] { get }
}

struct MenuContentCollectionViewCellModel: MenuContentCollectionViewCellInterface {
  var menuItems: [MenuItems]
}

private extension String {
  static var cellIdentifer = "MenuCollectionSubCollectionViewCell"
}

private let cellHeight: CGFloat = 450.0

class MenuContentCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: MenuCollectionSubCollectionViewCell.self)
      collectionView.contentInset = .zero
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: cellHeight)
      layout.scrollDirection = .vertical
      collectionView.collectionViewLayout = layout
      collectionView.isScrollEnabled = false
    }
  }
  
  //MARK: Private properties
  private var cellModel: MenuContentCollectionViewCellInterface?
  
  //MARK: Lifecycle methods
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.dataSource = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionViewHeightConstraint.constant = collectionView.contentSize.height
  }
  
  //MARK: Public properties
  func configure(with cellModel: MenuContentCollectionViewCellInterface) {
    self.cellModel = cellModel
    collectionView.reloadData()
    let items = Observable.just(cellModel.menuItems)
    let _ = items.bind(to: collectionView.rx.items(cellIdentifier: .cellIdentifer, cellType: MenuCollectionSubCollectionViewCell.self)) { (row, element, cell) in
      cell.configure(with: MenuCollectionSubCollectionViewCellModel(menu: element))
    }
  }
}
