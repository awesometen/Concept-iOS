//
//  CollectionCustomLayout.swift
//  Concept
//
//  Created by Vijay Jayapal on 02/12/20.
//

import UIKit

class CollectionCustomLayout: UICollectionViewFlowLayout {
  fileprivate var bannerWidth: CGFloat {
    let width = UIScreen.main.bounds.width - 24
    return UIDevice.current.userInterfaceIdiom == .pad ? width / 2 : width
  }
  
  //MARK: Private properties
  init(_ itemSize: CGSize = .zero) {
    super.init()
    self.itemSize = itemSize
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.minimumInteritemSpacing = 0
    self.minimumLineSpacing = 0
    self.scrollDirection = .horizontal
    self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    self.collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = self.collectionView, UIDevice.current.userInterfaceIdiom != .pad else {
      let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
      return latestOffset
    }
    let pageWidth = bannerWidth + self.minimumInteritemSpacing
    let approximatePage = collectionView.contentOffset.x/pageWidth
    let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))
    let flickVelocity = velocity.x * 0.3
    let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
    let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left
    return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
  }
}
