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

class MenuContentCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: MenuCollectionSubCollectionViewCell.self)
      collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 450)
      layout.scrollDirection = .vertical
      collectionView.collectionViewLayout = layout
      collectionView.isScrollEnabled = false
    }
  }
  
  //MARK: Lifecycle methods
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionViewHeightConstraint.constant = collectionView.contentSize.height
  }
  
  //MARK: Public properties
  func configure(with cellModel: MenuContentCollectionViewCellInterface) {
    collectionView.reloadData()
    let items = Observable.just(cellModel.menuItems)
    let _ = items.bind(to: collectionView.rx.items(cellIdentifier: "MenuCollectionSubCollectionViewCell", cellType: MenuCollectionSubCollectionViewCell.self)) { (row, element, cell) in
      cell.configure(with: MenuCollectionSubCollectionViewCellModel(menu: element))
    }
  }
}
