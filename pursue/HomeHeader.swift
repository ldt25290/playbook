//
//  HomeHeader.swift
//  pursue
//
//  Created by Jaylen Sanders on 7/2/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Firebase

class HomeHeader : UICollectionViewCell {
    
    var accessHomeController : HomeController?
    
    let homeLabel : UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var profilePhoto : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "steph").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc func handleProfile(){
        accessHomeController?.goToProfile()
    }
    
    func setupView(){
        addSubview(homeLabel)
        addSubview(profilePhoto)
        
        homeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 5, paddingRight: 0, width: homeLabel.intrinsicContentSize.width, height: homeLabel.intrinsicContentSize.height)
        profilePhoto.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 24, height: 24)
        profilePhoto.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
