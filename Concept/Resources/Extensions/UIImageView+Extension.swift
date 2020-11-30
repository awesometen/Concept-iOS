//
//  UIImageView+Extension.swift
//  Concept
//
//  Created by awesomej on 28/11/20.
//

import UIKit

fileprivate var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  func loadImageFromUrl(imageUrl: String, imageHandler: ((UIImage) -> Void)?) {
    guard let imageUrl = URL(string: imageUrl) else {
      self.image = nil
      return
    }
    if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
      DispatchQueue.main.async {
        self.image = cachedImage
        imageHandler?(cachedImage)
      }
      return
    }
    
    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
      guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      imageCache.setObject(image, forKey: (httpURLResponse.url?.absoluteString ?? "") as NSString)
      DispatchQueue.main.async() {
        self.image = image
        imageHandler?(image)
      }
    }.resume()
  }
}
