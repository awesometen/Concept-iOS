//
//  CurrentMenuCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import RxSwift

protocol CurrentMenuCollectionViewCellInterface {
  var categoryMenu: [String] { get }
  var selectedItem: String { get }
}

struct CurrentMenuCollectionViewCellModel: CurrentMenuCollectionViewCellInterface {
  var categoryMenu: [String]
  var selectedItem: String
}

private extension String {
  static let cellIdentifier = "CurrentMenuSubCollectionViewCell"
}

class CurrentMenuCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  //MARK: IBOutlet propertie
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: CurrentMenuSubCollectionViewCell.self)
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: 80)
      layout.scrollDirection = .horizontal
      collectionView.collectionViewLayout = layout
      collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }
  
  //MARK: Lifecycle
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.dataSource = nil
  }
  
  //MARK: Public properties
  func configure(with cellModel: CurrentMenuCollectionViewCellInterface) {
    collectionView.reloadData()
    var sorted = cellModel.categoryMenu.filter{ $0 != cellModel.selectedItem }
    sorted.insert(cellModel.selectedItem, at: 0)
    let items = Observable.just(sorted)
    let _ = items.bind(to: collectionView.rx.items(cellIdentifier: .cellIdentifier, cellType: CurrentMenuSubCollectionViewCell.self)) { (_, element, cell) in
      cell.configure(with: CurrentMenuSubCollectionViewCellModel(title: element, isSelected: cellModel.selectedItem == element))
    }
  }
}
