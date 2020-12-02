//
//  SecondaryViewController.swift
//  Concept
//
//  Created by Vijay Jayapal on 28/11/20.
//

import UIKit
import Pulley
import RxSwift

private extension String {
  static let cellIdentifier = "MainContentHolderCollectionViewCell"
}

class SecondaryViewController: UIViewController {
  
  @IBOutlet private weak var mainMenuCollectionView: UICollectionView! {
    didSet {
      mainMenuCollectionView.registerReusableCell(cellType: MainContentHolderCollectionViewCell.self)
      mainMenuCollectionView.contentInset = UIEdgeInsets(top: UIDevice.current.hasTopNotch ? 24 : 180, left: 0, bottom: 0, right: 0)
      let layout = CollectionCustomLayout()
      layout.scrollDirection = .horizontal
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 900)
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
      mainMenuCollectionView.collectionViewLayout = layout
      mainMenuCollectionView.isScrollEnabled = true
    }
  }
  
  //MARK: Public properties
  var presenter: SecondaryViewToPresenter?
  
  //MARK: Private properties
  private var menuItems: MenuListResponse?
  
  //MARK: Life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.fetchMenuItems()
  }
  
  private func reloadSection() {
    guard let menus = menuItems?.foodMenu, let submenu = menuItems?.subMenus else { return }
    let items = Observable.just(menus)
    let _ = items.bind(to: mainMenuCollectionView.rx.items(cellIdentifier: .cellIdentifier, cellType: MainContentHolderCollectionViewCell.self)) { [weak self] (row, element, cell) in
      let model = MainContentHolderCollectionCellModel(categories: submenu, currentIndex: row, menuItems: menus[row] , viewDelegate: self)
      cell.configure(with: model)
    }
  }
}

extension SecondaryViewController: SecondaryPresenterToView {
  func fetchedItems(menu: MenuListResponse) {
    menuItems = menu
    mainMenuCollectionView.reloadData()
    reloadSection()
  }
}

extension SecondaryViewController: MainContentToViewDelegation {
  func onForcePullDown() {
    presenter?.baseDelegate?.updatePulley(position: .partiallyRevealed)
  }
  
  func onForceDrawerUp() {
    presenter?.baseDelegate?.updatePulley(position: .open)
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
  }
  
  func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat) {
    presenter?.baseDelegate?.prepareForFullScreen(with: bottomSafeArea)
  }
}
