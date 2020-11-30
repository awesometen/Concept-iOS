//
//  Reusable.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import Foundation
import UIKit

protocol Reusable: class {

  static var reuseIdentifier: String { get }

}
extension Reusable {

  static var reuseIdentifier: String {
    return String(describing: self)
  }

}

protocol NibReusable: Reusable, NibLoadable {}
protocol NibLoadable: class {

  static var nib: UINib { get }

}
extension NibLoadable {

  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }

}

protocol GenericNibReusable: NibReusable {

  associatedtype CellModel

  func configure(with cellModel: CellModel)
  func configure(with cellModel: CellModel, indexPath: IndexPath)

}

protocol CellHeightProvider {

  static var height: CGFloat? { get }
  static var estimatedHeight: CGFloat? { get }
}

extension CellHeightProvider {

  static var height: CGFloat? { return nil }
  static var estimatedHeight: CGFloat? { return nil }
}

typealias GenericHeightCell = GenericNibReusable & CellHeightProvider

extension GenericNibReusable {
  func configure(with cellModel: CellModel) {

  }

  func configure(with cellModel: CellModel, indexPath: IndexPath) {
    configure(with: cellModel)
  }

}
