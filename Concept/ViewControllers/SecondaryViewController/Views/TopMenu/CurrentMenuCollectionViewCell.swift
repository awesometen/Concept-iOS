//
//  CurrentMenuCollectionViewCell.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import UIKit

protocol CurrentMenuCollectionViewCellInterface {
  var categoryMenu: [String] { get }
  var selectedItem: String { get }
}

struct CurrentMenuCollectionViewCellModel: CurrentMenuCollectionViewCellInterface {
  var categoryMenu: [String]
  var selectedItem: String
}


class CurrentMenuCollectionViewCell: UICollectionViewCell, GenericHeightCell {
  
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.registerReusableCell(cellType: CurrentMenuSubCollectionViewCell.self)
    }
  }
  
  //MARK: Private properties
  private var cellModel: CurrentMenuCollectionViewCellInterface?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configure(with cellModel: CurrentMenuCollectionViewCellInterface) {
    self.cellModel = cellModel
    collectionView.reloadData()
  }
}

extension CurrentMenuCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CurrentMenuSubCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
    guard let category = cellModel?.categoryMenu[indexPath.section] else { return cell }
    let model = CurrentMenuSubCollectionViewCellModel(title: category, isSelected: category == cellModel?.selectedItem)
    cell.configure(with: model)
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return cellModel?.categoryMenu.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width/3, height: 70)
  }
}
