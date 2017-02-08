//
//  Channel.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class Channel: NSObject {

    var profile_image_name: String?
    var name: String?
    
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
}
