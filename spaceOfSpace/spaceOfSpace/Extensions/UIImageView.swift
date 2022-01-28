//
//  UIImage.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.04.2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    ///Function to retrieve Image from API URL
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            UIView.transition(with: self, duration: 0.75, options: .transitionCrossDissolve, animations: {
                self.image = cachedImage
            }, completion: nil)
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        UIView.transition(with: self, duration: 0.75, options: .transitionCrossDissolve, animations: {
                            self.image = placeHolder
                        }, completion: nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                            UIView.transition(with: self, duration: 0.75, options: .transitionCrossDissolve, animations: {
                                self.image = downloadedImage
                            }, completion: nil)
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
