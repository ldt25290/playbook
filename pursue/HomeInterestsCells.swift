//
//  HomeInterestsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/18/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeInterestsCells : UICollectionViewCell {
    
    let photo : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let photoBackground : HomeCellRectangleView = {
        let view = HomeCellRectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "Have a vision to work towards"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Black", size: 12)
        return label
    }()
    
    let postTypeLabel : UILabel = {
        let label = UILabel()
        label.text = "Principles"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Bold", size: 12)
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont(name: "Lato-Bold", size: 10)
        label.textColor = .white
        return label
    }()
    
    let userPhoto : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "samuel-l").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let gradientView : GradientView = {
        let view = GradientView()
        view.colors = [.gray, .lightGray]
        view.locations = [0.8, 1.0]
        view.direction = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupView(){
        addSubview(photoBackground)
        addSubview(photo)
        addSubview(userPhoto)
        addSubview(usernameLabel)
        addSubview(postTypeLabel)
        addSubview(detailLabel)
        
        photoBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photo.anchor(top: photoBackground.topAnchor, left: photoBackground.leftAnchor, bottom: photoBackground.bottomAnchor, right: photoBackground.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userPhoto.anchor(top: photo.topAnchor, left: photo.leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        usernameLabel.anchor(top: nil, left: photo.leftAnchor, bottom: photo.bottomAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 12, paddingRight: 8, width: 0, height: 14)
        postTypeLabel.anchor(top: nil, left: photo.leftAnchor, bottom: usernameLabel.topAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 6, paddingRight: 8, width: 0, height: 14)
        detailLabel.anchor(top: nil, left: photo.leftAnchor, bottom: postTypeLabel.topAnchor, right: photo.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 6, paddingRight: 8, width: 0, height: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

