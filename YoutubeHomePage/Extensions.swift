//
//  Extensions.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-24.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

//Use a local cache to avoid repetitious network calls for images. Uncomment the print statements below to see it in action when you run the app

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    //Custom class to include the urlString property. This urlString is used to check that the image that has returned from the network call is indeed intended for this particular imageView
    
    var urlString: String?
    
    func loadImageUsingURL(URLstring: String) {
        
        self.urlString = URLstring
        
        if let imageFromCache = imageCache.object(forKey: URLstring as AnyObject) as? UIImage {
            self.image = imageFromCache
            //print("From Cache")
            return
        }
        
        let url = URL(string: URLstring)

        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "load image error")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.urlString == URLstring {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: URLstring as AnyObject)
                //print("From network call")
            }
        }).resume()
    }
}
