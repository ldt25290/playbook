//
//  PursuitPrincipleCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 12/12/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PursuitPrincipleCells : UICollectionViewCell  {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 4
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "ferrari").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let postDetail : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Working on this."
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "1h ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    func setupView(){
        addSubview(imageView)
        addSubview(postDetail)
        addSubview(timeLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 215)
        postDetail.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
        timeLabel.anchor(top: postDetail.bottomAnchor, left: postDetail.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hero.isEnabled = true
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
