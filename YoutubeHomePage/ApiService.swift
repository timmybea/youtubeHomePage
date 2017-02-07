//
//  ApiService.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-06.
//  Copyright © 2017 Tim Beals. All rights reserved.
//


//A singleton that can be used to perform the data task. It has a completion block that passes an array of videos so that the data source in the Home Controller can be set. Note that the completion block is called after the dispatch main call.

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            } else {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    var videos = [Video]()
                    
                    for dictionary in json as! [[String: AnyObject]] { //an array or dictionaries
                        
                        let newVideo = Video()
                        newVideo.title = dictionary["title"] as! String?
                        newVideo.numberOfViews = dictionary["number_of_views"] as? NSNumber
                        newVideo.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                        
                        let jsonChannel = dictionary["channel"] as! [String: AnyObject]
                        
                        let newChannel = Channel()
                        newChannel.name = jsonChannel["name"] as? String
                        newChannel.profileImageName = jsonChannel["profile_image_name"] as? String
                        newVideo.channel = newChannel
                        
                        videos.append(newVideo)
                        
                        DispatchQueue.main.async {
                            //self.collectionView?.reloadData()
                            completion(videos)
                        }
                    }
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }).resume() //resume is the command that executes the urlsession.
    }
    
}
