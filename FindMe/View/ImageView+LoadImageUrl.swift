//
//  ImageView+LoadImageUrl.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-21.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation
import UIKit

var imageCache  = NSCache<NSString, UIImage>()

extension UIImageView{
    /*
     This function uses a cache
     */
    func loadImageFromUrl(urlString: String) {
        
        if urlString == "profileTemplatePhoto"{
            self.image = #imageLiteral(resourceName: "profileTemplatePhoto")
            return
        }
        
        let url = URL(string: urlString)!
        
        //if the image is already in cache then just set it and return
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        }
            //if its not, then load it and put it in the cache for future use
        else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else{
                    return
                }
                DispatchQueue.main.async {
                    if let imageData = data, let theImage = UIImage(data: imageData){
                        imageCache.setObject(theImage, forKey: url.absoluteString as NSString)
                        self.image = theImage
                    }
                }
            }.resume()
        }
    }
}
