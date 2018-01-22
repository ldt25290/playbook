//
//  HomeRow.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/21/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import iCarousel

protocol HomeRowImageEngagements {
    func homeRowImageTapped()
    func homeRowImageHeld()
}

class HomeRow: UICollectionViewCell, HomeImageEngagements, iCarouselDataSource, iCarouselDelegate {
    
    var accessHomeController : HomeController?
    var homeDelegate : HomeRowImageEngagements?
    
    var itemView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var carouselView : iCarousel = {
       let ic = iCarousel()
        return ic
    }()
    
    lazy var subCarouselView : iCarousel = {
      let ic = iCarousel()
        ic.type = .invertedTimeMachine
        return ic
    }()
    
    var isLiked = false
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    func homeTapped() {
        homeDelegate?.homeRowImageTapped()
    }
    
    func homeHeld() {
        homeDelegate?.homeRowImageHeld()
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return imageNames.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        tempView.layer.cornerRadius = 4
        tempView.layer.masksToBounds = true
        
        let carouselImage = UIImageView()
        carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
        carouselImage.contentMode = .scaleAspectFill
        
        tempView.addSubview(carouselImage)
        carouselImage.anchor(top: tempView.topAnchor, left: tempView.leftAnchor, bottom: tempView.bottomAnchor, right: tempView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let shadowButton = UIButton()
        shadowButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        shadowButton.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        
        tempView.addSubview(shadowButton)
        shadowButton.anchor(top: nil, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 20, paddingRight: 0, width: 80, height: 30)
        toggleLike(button: shadowButton)
        
        let imageLabel = UIView()
        imageLabel.backgroundColor = .red
        
        tempView.addSubview(imageLabel)
        imageLabel.anchor(top: tempView.bottomAnchor, left: tempView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 40)

        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.6
        }
        
        return value
    }
    
    @objc func toggleLike(button : UIButton){
        isLiked = !isLiked
        
        if isLiked == true {
            button.backgroundColor = .white
            button.setTitle("Like", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
        } else {
            button.backgroundColor = .black
            button.setTitle("Liked", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: bottomAnchor, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 0, height: 0)
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
