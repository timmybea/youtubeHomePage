//
//  ApiService.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-06.
//  Copyright © 2017 Tim Beals. All rights reserved.
//


//A singleton that can be used to perform the data task. It has a completion block that passes an array of videos so that the data source in the Home Controller can be set. Note that the completion block is called after the dispatch main call.

//json pretty print to view json in chrome

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseURLString: String = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    //Notice the more succinct syntax where the completion of fetchFeed is being passed into fetchVideos completion block.
    func fetchFeed(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "\(baseURLString)/home.json")
        fetchVideos(url: url!, completion: completion)
    }
    
    func fetchTrending(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "\(baseURLString)/trending.json")
        fetchVideos(url: url!) { (videos: [Video]) in
            completion(videos)
        }
    }
    
    func fetchSubscriptions(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "\(baseURLString)/subscriptions.json")
        fetchVideos(url: url!) { (videos: [Video]) in
            completion(videos)
        }
    }
    
    func fetchVideos(url: URL, completion: @escaping ([Video]) -> ()) {
        
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "fetch error")
                return
            } else {
                
                do {
                    //Look at bottom of file to see regular way to parse json without setValueForKeys
                    if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                        var videos = [Video]()
                        
                        for dictionary in jsonDictionaries { //an array or dictionaries
                            //check out setValueForKey in the video object to see the inititalization of the video and channel objects
                            let newVideo = Video(dictionary: dictionary)
                            videos.append(newVideo)
                            DispatchQueue.main.async {
                                completion(videos)
                            }
                        }
                    }
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }).resume() //resume is the command that executes the urlsession.
    }
    
}

//THIS WAS INSIDE THE DO-CATCH

//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] { //an array or dictionaries
//    
//    let newVideo = Video()
//    newVideo.title = dictionary["title"] as! String?
//    newVideo.numberOfViews = dictionary["number_of_views"] as? NSNumber
//    newVideo.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//    
//    let jsonChannel = dictionary["channel"] as! [String: AnyObject]
//    
//    let newChannel = Channel()
//    newChannel.name = jsonChannel["name"] as? String
//    newChannel.profileImageName = jsonChannel["profile_image_name"] as? String
//    newVideo.channel = newChannel
//    
//    videos.append(newVideo)
//    
//    DispatchQueue.main.async {
//        //self.collectionView?.reloadData()
//        completion(videos)
//}
