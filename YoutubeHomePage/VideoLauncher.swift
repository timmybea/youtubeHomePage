//
//  VideoLauncher.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    
    class func launchVideo() {
        //setup background view with animation        
        if let window = UIApplication.shared.keyWindow {
            let view = UIView(frame: window.frame)
            view.backgroundColor = UIColor.white
            
            //Note that this height is for standard 16:9 screen ratio used by youtube
            let height = view.frame.width * 9 / 16
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: frame)
            
            view.frame = CGRect(x: window.frame.width - 5, y: window.frame.height - 5, width: 5, height: 5)
        
            view.addSubview(videoPlayerView)
            window.addSubview(view)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = window.frame
                
            }, completion: { (true) in
                //print("animation complete")
                UIApplication.shared.setStatusBarHidden(true, with: .slide)
            })
        }
        
        
        
    }
    
}
