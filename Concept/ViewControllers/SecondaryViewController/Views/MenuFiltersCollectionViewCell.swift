//
//  MenuFiltersCollectionViewCell.swift
//  Concept
//
//  Created by Vijay Jayapal on 29/11/20.
//

import UIKit

protocol MenuFiltersCollectionViewCellInterfaces {
  var availableFilter: [String]? { get }
}

struct MenuFiltersCollectionViewCellModel: MenuFiltersCollectionViewCellInterfaces {
  var availableFilter: [String]?
}

class MenuFiltersCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.registerReusableCell(cellType: MenuFiltersSubCollectionViewCell.self)
    }
  }
  
  //MARK: Private Properties
  private var cellModel: MenuFiltersCollectionViewCellInterfaces?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with cellModel: MenuFiltersCollectionViewCellInterfaces) {
    self.cellModel = cellModel
    collectionView.reloadData()
  }
}

extension MenuFiltersCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MenuFiltersSubCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
    guard let filter = cellModel?.availableFilter?[indexPath.section] else { return cell }
    let model = MenuFiltersSubCollectionViewCellModel(title: filter, isSelected: false)
    cell.configure(with: model)
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return cellModel?.availableFilter?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 120, height: 46)
  }
}
