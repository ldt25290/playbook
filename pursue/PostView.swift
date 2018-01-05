//
//  PostView.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/14/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit

class PostView : UICollectionViewCell {
        
    let postDescription : UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: "I need some help getting started with marketing my profile on Instagram.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Jubilee"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 25))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile-2")
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    let cellId = "cellId"
    let commentId = "commentId"
    let relatedId = "relatedId"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    func setupView(){
        addSubview(userPhoto)
        
        userPhoto.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .gray
        
        addSubview(usernameLabel)
        addSubview(postDescription)
        addSubview(underlineView)
        usernameLabel.anchor(top: userPhoto.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
        postDescription.anchor(top: usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: userPhoto.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: postDescription.intrinsicContentSize.width, height: postDescription.intrinsicContentSize.height)
        underlineView.anchor(top: postDescription.bottomAnchor, left: usernameLabel.leftAnchor, bottom: nil, right: userPhoto.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
