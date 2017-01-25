//
//  MenuCell.swift
//  YoutubeHomePage
//
//  Created by Tim Beals on 2017-01-24.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate)
        //iv.tintColor = ColorManager.customIconRed()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let highlightBar: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func setupCell() {
        //self.backgroundColor = UIColor.yellow
        addSubview(imageView)
        addSubview(highlightBar)
        
        addConstraintsWithFormat(format: "H:[v0(20)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: imageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: highlightBar)
        addConstraintsWithFormat(format: "V:[v0(5)]|", views: highlightBar)
        
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : ColorManager.customIconRed()
            highlightBar.backgroundColor = isHighlighted ? UIColor.white : ColorManager.customRed()
        }
    }

    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : ColorManager.customIconRed()
            highlightBar.backgroundColor = isSelected ? UIColor.white : ColorManager.customRed()        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
