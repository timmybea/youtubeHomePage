//
//  Video.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class Video: NSObject {

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
            //execute the default setValue function (super)
            super.setValue(value, forKey: key)
        }
    }
    
}
