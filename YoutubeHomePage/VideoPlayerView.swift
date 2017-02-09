//
//  VideoPlayerView.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        setupVideoPlayer()

        controlsContainerView.frame = self.frame
        self.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVideoPlayer() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/videoplayerhosting.appspot.com/o/Gifter.mp4?alt=media&token=ec77e2bf-527e-4b60-8baa-2cabed68c767"
        
        let videoURL = NSURL(string: urlString)
        let player = AVPlayer(url: videoURL as! URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player.play()
    }

}
