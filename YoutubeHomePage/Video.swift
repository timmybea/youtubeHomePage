//
//  Video.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        //To prevent a crash if new or extra keys appear in the json, we need to test if the keys are able to be set:
        let upperFirstChar = String(key.first!).uppercased()
        let index = key.index(key.startIndex, offsetBy: 1)
        let removedFirstLetter = key.substring(from: index)
        let CapitalizedKey = upperFirstChar + removedFirstLetter
        
        
        let selector = NSSelectorFromString("set\(CapitalizedKey):")
        let response = self.responds(to: selector)
        
        
        if !response {
            return
        } else {
            //NSObject setValue method
            super.setValue(value, forKey: key)
        }
    }
    
}


class Video: SafeJsonObject {

    var thumbnail_image_name: String?
    var title: String?
    var createdDate: String?
    var number_of_views: NSNumber?
    var duration: NSNumber = 0.0
    
    var channel: Channel?
    
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    //This function is called iteratively by setValuesForKeys in init method.
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            self.channel = Channel(dictionary: value as! [String : AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}
