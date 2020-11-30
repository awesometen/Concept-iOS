//
//  SecondaryViewController.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import Pulley
import RxSwift

class SecondaryViewController: UIViewController {
  
  @IBOutlet private weak var mainMenuCollectionView: UICollectionView! {
    didSet {
      mainMenuCollectionView.registerReusableCell(cellType: CurrentMenuCollectionViewCell.self)
      mainMenuCollectionView.registerReusableCell(cellType: MenuFiltersCollectionViewCell.self)
      mainMenuCollectionView.registerReusableCell(cellType: MenuContentCollectionViewCell.self)
      mainMenuCollectionView.dataSource = self
      mainMenuCollectionView.delegate = self
      mainMenuCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      mainMenuCollectionView.isScrollEnabled = true
    }
  }
  
  //MARK: Public properties
  var presenter: SecondaryViewToPresenter?
  let categoryMenu = ["Pizza", "Burger", "Drinks"]
  
  
  private var menuItems: MenuListResponse?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.fetchMenuItems()
  }
  
}

extension SecondaryViewController: SecondaryPresenterToView {
  func fetchedItems(menu: MenuListResponse) {
    menuItems = menu
    mainMenuCollectionView.reloadData()
  }
}


extension SecondaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      let cell: CurrentMenuCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: CurrentMenuCollectionViewCellModel(categoryMenu: categoryMenu, selectedItem: "Pizza"))
      return cell
    case 1:
      let cell: MenuFiltersCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: MenuFiltersCollectionViewCellModel(availableFilter: ["Veg", "Non veg"]))
      return cell
    case 2:
      guard let menuItems = menuItems?.foodMenu?.first?.menuItems else { return UICollectionViewCell() }
      let cell: MenuContentCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: MenuContentCollectionViewCellModel(menuItems: menuItems))
      return cell
    default:
      let cell: CurrentMenuCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
      cell.configure(with: CurrentMenuCollectionViewCellModel(categoryMenu: categoryMenu, selectedItem: "Pizza"))
      return cell
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
}

extension SecondaryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
      return CGSize(width: UIScreen.main.bounds.width, height: 60)
    case 1:
      return CGSize(width: UIScreen.main.bounds.width, height: 40)
    case 2:
      return CGSize(width: UIScreen.main.bounds.width, height: 900)
    default:
      return CGSize.zero
    }
    
  }
}


extension SecondaryViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
    if translation.y > 0 {
      print("down down")
    } else {
      print("up up")
      presenter?.baseDelegate?.updatePulley(position: .open)      
    }
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("did scorll")
  }
}

extension SecondaryViewController: PulleyDrawerViewControllerDelegate {
  
  func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
    return 0
  }
  
  func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
    return UIScreen.main.bounds.height / 2
  }
  
  func supportedDrawerPositions() -> [PulleyPosition] {
    return [.partiallyRevealed, .open]
  }
  
  func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
    print(bottomSafeArea)
    if drawer.drawerPosition == .open {
      
      
    }
  }
  
  func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat) {
    print(bottomSafeArea)
  }
}
