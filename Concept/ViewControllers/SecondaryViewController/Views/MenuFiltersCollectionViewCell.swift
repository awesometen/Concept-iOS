//
//  MenuFiltersCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit
import RxSwift

protocol MenuFiltersCollectionViewCellInterfaces {
  var availableFilter: [String]? { get }
}

struct MenuFiltersCollectionViewCellModel: MenuFiltersCollectionViewCellInterfaces {
  var availableFilter: [String]?
}

class MenuFiltersCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerReusableCell(cellType: MenuFiltersSubCollectionViewCell.self)
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: 140, height: 46)
      layout.minimumInteritemSpacing = 2
      layout.scrollDirection = .vertical
      collectionView.collectionViewLayout = layout
    }
  }

  //MARK: Private Properties
  private var cellModel: MenuFiltersCollectionViewCellInterfaces?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.dataSource = nil
  }
  
  //MARK: Public methods
  func configure(with cellModel: MenuFiltersCollectionViewCellInterfaces) {
    self.cellModel = cellModel
    collectionView.reloadData()
    guard let filters = self.cellModel?.availableFilter else { return }
    let items = Observable.just(filters)
    let dispose = items.bind(to: collectionView.rx.items(cellIdentifier: "MenuFiltersSubCollectionViewCell", cellType: MenuFiltersSubCollectionViewCell.self)) { (row, element, cell) in
      cell.configure(with: MenuFiltersSubCollectionViewCellModel(title: element, isSelected: false))
    }
  }
}
