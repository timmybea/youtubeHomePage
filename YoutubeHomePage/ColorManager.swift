//
//  ColorManager.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-24.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ColorManager: NSObject {
    
    class func customRed() -> UIColor {
        return UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    }
    
    class func customDarkRed() -> UIColor {
        return UIColor(red: 194/255, green: 31/255, blue: 31/255, alpha: 1)
    }
    
    class func customGray() -> UIColor {
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
}
