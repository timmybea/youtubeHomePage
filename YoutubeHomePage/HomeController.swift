//
//  HomeController.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?
//= {
//        var dontLetMeDownVideo = Video()
//        dontLetMeDownVideo.title = "The Beatles - Don't Let Me Down"
//        dontLetMeDownVideo.thumbnailImageName = "dontLetMeDown"
//        dontLetMeDownVideo.numberOfViews = 47464731
//        dontLetMeDownVideo.createdDate = "2 years ago"
//        
//        let beatlesChannel = Channel()
//        beatlesChannel.name = "TheBeatlesVEVO"
//        beatlesChannel.profileImageName = "profile"
//        
//        dontLetMeDownVideo.channel = beatlesChannel
//        return [dontLetMeDownVideo]
//    }()
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func fetchVideoData() {
     
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            } else {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    self.videos = [Video]()
                    
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
                        
                        self.videos?.append(newVideo)
                        
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }).resume() //resume is the command that executes the urlsession.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideoData()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        //make collectionview begin beneath the menu bar
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
    
    }

    
    private func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(moreAction))
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        moreBarButtonItem.tintColor = UIColor.white
        searchBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleSearch() {
        print(123)
    }
    
    func moreAction() {
        
    }
    
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video  = videos?[indexPath.item]
        return cell
    }
    
    //MARK: Delegate FlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 88 + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

