//
//  TrendingCell.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-08.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideoData() {

        ApiService.sharedInstance.fetchTrending { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
