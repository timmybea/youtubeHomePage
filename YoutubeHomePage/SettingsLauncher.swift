//
//  SettingsLauncher.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-02-06.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//Notice that we can use an enum for the setting name which acts as a safeguard. When we check to see which setting was selected to perform a seqgue, we're not checking against a more vulnerable string.
class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case Feedback = "Send feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var homeController: HomeController?
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 45
    
    let settingsArray: [Setting] = [Setting(name: .Settings, imageName: "Settings"), Setting(name: .TermsPrivacy, imageName: "Lock"), Setting(name: .Feedback, imageName: "Feedback"), Setting(name: .Help, imageName: "Help"), Setting(name: .SwitchAccount, imageName: "contacts"), Setting(name: .Cancel, imageName: "Cancel")]
    
    func launchSettings() {
        
        //Animate black transparent view to cover entire window.
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settingsArray.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        }
    }
    
    func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }) { (completed: Bool) in
            //print(setting.name)
            if setting.name != .Cancel {
                self.homeController?.pushToSettingsController(setting: setting)
            }
        }
    }
    
    //MARK: CollectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settingsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let setting: Setting = settingsArray[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settingsArray[indexPath.item]
        
        handleDismiss(setting: setting)
    }


    
    
    override init() {
        super.init()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    
    
    }
}
