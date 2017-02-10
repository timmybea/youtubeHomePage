//
//  VideoLauncher.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {

    var view: UIView = {
        let view = UIView()
        return view
    }()
    
    func launchVideo() {
        //setup background view with animation        
        if let window = UIApplication.shared.keyWindow {
            view = UIView(frame: window.frame)
            view.backgroundColor = UIColor.white
            
            //Note that this height is for standard 16:9 screen ratio used by youtube
            let height = view.frame.width * 9 / 16
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: frame)
            
            view.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            view.addSubview(videoPlayerView)
            window.addSubview(view)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.frame = window.frame
                
            }, completion: { (true) in
                //print("animation complete")
                UIApplication.shared.setStatusBarHidden(true, with: .slide)
            })
        }
    }

    func handleDismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                self.view.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
            }
        }, completion: { (true) in
            //print("animation complete")
            UIApplication.shared.setStatusBarHidden(false, with: .slide)
        })
    }
}
