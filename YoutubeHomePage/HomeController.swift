//
//  HomeController.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let feedId = "feedId"
    let trendingId = "trendingId"
    let subscriptionId = "subscriptionId"
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    let headings: [String] = ["Home", "Trending", "Subscriptions", "Account"]
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel?.textColor = UIColor.white
        titleLabel?.text = "  Home"
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingId)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionId)
        
        //make collectionview begin beneath the menu bar
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        moreBarButtonItem.tintColor = UIColor.white
        searchBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleSearch() {
        print(123)
    }
    
    
    //LAZY VARS ARE COOL! this proprety only gets initialized once when it is needed. This is not initialized when the Home Controller is initialized which means that we have access to the 'self' property. It also doesn't make sense to repeatedly set the launcher homeController property to self, so this allows us to do it only the once. This means that our Settings launcher can call the HomeController function to push a new view controller in it's completion block when a settings item is selected.
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func handleMore() {
        //show menu with options
        settingsLauncher.launchSettings()
    }
    
    func pushToSettingsController(setting: Setting) {
            let settingViewController = UIViewController()
            settingViewController.navigationItem.title = setting.name.rawValue
            settingViewController.view.backgroundColor = UIColor.white
        
        
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            settingViewController.view.addSubview(label)
            label.centerXAnchor.constraint(equalTo: settingViewController.view.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: settingViewController.view.centerYAnchor, constant: -50).isActive = true
            label.widthAnchor.constraint(equalTo: settingViewController.view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 60)
        
            label.numberOfLines = 2
            label.text = "Empty demonstration view controller"
            label.textColor = ColorManager.customRed()
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textAlignment = .center
            
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    private func setupMenuBar() {
        let redView = UIView()
        redView.backgroundColor = ColorManager.customRed()
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        //Create disappearing nav bar effect with vertical scrolling
        navigationController?.hidesBarsOnSwipe = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func scrollToItemAt(index: Int) {
        let indexPath: NSIndexPath = NSIndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleFor(index: index)
    }
    
    
    //MARK: use the content offset of the collection view to move the white horizontal view of the menu bar
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        let index = scrollView.contentOffset.x / 4
        menuBar.horizontalViewLeftAnchor?.constant = index
    }
    
    
    //MARK: Use scrollview method to highlight the apporopriate button in the menubar
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let item: Int = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath: IndexPath = IndexPath(item: item, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitleFor(index: item)
    }
    
    func setTitleFor(index: Int) {
        let heading = "  \(headings[index])"
        titleLabel?.text = heading
    }
    
    //MARK: Create cells to correspond with each button in the MenuBar
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String?
        if indexPath.item == 1 {
            identifier = trendingId
        } else if indexPath.item == 2 {
            identifier = subscriptionId
        } else {
            identifier = feedId
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier!, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}

