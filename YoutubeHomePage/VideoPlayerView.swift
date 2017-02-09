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
    
    var player: AVPlayer?
    var isSettingPlay = true
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePausePlayTouch), for: .touchUpInside)
        
        
        return button
    }()
    
    func handlePausePlayTouch() {
        if isSettingPlay {
            //print("Pause button pressed")
            player?.pause()
            let image = UIImage(named: "Play")
            pausePlayButton.setImage(image, for: .normal)
            isSettingPlay = false
        } else {
            player?.play()
            let image = UIImage(named: "Pause")
            pausePlayButton.setImage(image, for: .normal)
            isSettingPlay = true
        }
    }
    
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    var videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = ColorManager.customRed()
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChangedValue), for: .valueChanged)
        return slider
    }()
    
    func handleSliderChangedValue() {
        print(slider.value)
        
        //player?.seek(to: <#T##CMTime#>, completionHandler: { (completedSeek) in
            //do something here
        //})
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        setupVideoPlayer()

        controlsContainerView.frame = self.frame
        self.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.isHidden = true
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        controlsContainerView.addSubview(slider)
        slider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVideoPlayer() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/videoplayerhosting.appspot.com/o/Gifter.mp4?alt=media&token=ec77e2bf-527e-4b60-8baa-2cabed68c767"
        
        let videoURL = NSURL(string: urlString)
        player = AVPlayer(url: videoURL as! URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        
        //This keyPath is called when the AVPlayer begins rendering frames. In other words, when the video has loaded and starts playing. Notice the observeValue function below...
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            
            if let duration = player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d", Int(totalSeconds) % 60)
                let minutesText = String(format: "%02d", Int(totalSeconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }

}
