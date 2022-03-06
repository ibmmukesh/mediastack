//
//  ImageDownloader.swift
//  mediastack
//
//  Created by Mukesh Lokare on 06/03/22.
//

import UIKit
class ImageDownloader: NSObject {

    func downloadAndCacheImage(url:String, onSuccess:@escaping (_ image:UIImage?, _ url: String) -> Void, onFailure:@escaping (_ error:Error?) -> Void) -> Void {
        
        if let image = ImageDownloadManager.sharedInstance.getImage(forUrl: url){
            onSuccess(image, url)
        }else{
            if let finalUrl = URL(string: url ){
                URLSession.shared.dataTask(with: finalUrl, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        onFailure(error)
                    }else{
                        if let image = UIImage(data: data!){
                            ImageDownloadManager.sharedInstance.setImage(image: image, forKey: url)
                            onSuccess(image, url)
                        }else{
                            onFailure(NSError(domain: "", code: 100, userInfo: ["reason":"Unable to download image"]))
                        }
                    }
                }).resume()
            }
        }
    }
}
