//
//  videoCell.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-23.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class videoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        //MARK: Horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //MARK: Vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        //MARK: titleLabel constraints
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //MARK: subtitleTextView constraints
        addConstraint(NSLayoutConstraint.init(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint.init(item: subtitleTextView, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint.init(item: subtitleTextView, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))

    }
    
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dontLetMeDown")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Beatles - Don't Let Me Down"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TheBeatlesVEVO • 47,464,731 views • 1 year ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.customGray()
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}








































