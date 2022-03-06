//
//  UIImageView+Cache.swift
//  mediastack
//
//  Created by Mukesh Lokare on 06/03/22.
//

import UIKit

extension UIImageView {
    // way to hack stored property in extension, we using static hence needed dictionary to store based on address
    private static var urlStore = [String:String]()

    func setImage(url: String, placeholderImage: UIImage? = nil) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView.urlStore[tmpAddress] = url
        
        if let image = placeholderImage {
            self.image = image
        } else{
            self.backgroundColor = .gray
        }
        
        ImageDownloader().downloadAndCacheImage(url: url, onSuccess: { (image, url) in
            DispatchQueue.main.async {
            if UIImageView.urlStore[tmpAddress] == url {
                        self.image = image
                        self.backgroundColor = .clear
                    }
            }
        }) { error in
        }
    }
}
