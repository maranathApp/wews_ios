//
//  UIImageView+Extension.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/10/20.
//  Copyright © 2020 Maranathapp. All rights reserved.
//

import UIKit.UIImage

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    enum LoadingError: Error {
        case loadingFailed
    }

    func load(from imageURL: URL?, completionHandler: @escaping (Error?) -> Void) {

        guard let url = imageURL, imageCache.object(forKey: url.absoluteString as NSString) == nil else {
            DispatchQueue.main.async { [weak self] in
                self?.image = imageCache.object(forKey: (imageURL?.absoluteString ?? "") as NSString)
                completionHandler(nil)
            }
            
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                self?.image = nil
                completionHandler(error)
            } else {
                if let imageToCache = UIImage(data: data.unsafelyUnwrapped) {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self?.image = imageToCache
                        completionHandler(nil)
                    }
                } else {
                    completionHandler(LoadingError.loadingFailed)
                }
            }
        }.resume()
    }

}
