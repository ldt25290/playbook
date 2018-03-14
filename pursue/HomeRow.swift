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
    func homeRowScrolled(for cell : HomeRow)
}

class HomeRow: UICollectionViewCell {
    
    var accessHomeController : HomeContainer?
    var homeDelegate : HomeRowImageEngagements?
    let pursuitId = "pursuitId"
    let principleId = "principleId"
    let stepId = "stepId"
    var isLeft = true
    var isRight = true
    var cellIndex : Int = 0
    var isLiked = false
    
    let imageNames = ["ferrari", "pagani", "travel", "contacts", "3d-touch"]
    let profileNames = ["profile-1", "profile-2", "profile-3", "profile-4", "profile-5"]
    let homeDescriptions = ["iChat App", "New York Exchange", "Travel App", "Contact Page", "Settings 3d touch"]
    
    lazy var carouselView : iCarousel = {
       let ic = iCarousel()
        return ic
    }()
    
    lazy var subCarouselView : iCarousel = {
      let ic = iCarousel()
        return ic
    }()
    
    lazy var optionButton : UIButton = {
        let button = UIButton()
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    
    @objc func showOptions(){
        accessHomeController?.optionClicked()
    }
    
    func handleChangeToDetail(viewType : String) {
        switch viewType {
        case "isPrinciplesDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPrinciplesDetail")
        case "isPursuitDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isPursuitDetail")
        case "isImageDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
        case "isDiscussionDetail":
            accessHomeController?.handleChangeToDetail(viewType: "isDiscussionDetail")
        default:
            assert(false, "Not a valid view type")
        }
    }
    
    func imageView(){
        accessHomeController?.imageView()
    }
    
    @objc func toggleLike(label : UILabel, index : Int){
        label.backgroundColor = .clear
        label.text = homeDescriptions[index]
    }
    
    @objc func showDetail(){
        accessHomeController?.handleChangeToDetail(viewType: "isImageDetail")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousels()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeRow : iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        switch carousel {
        case carouselView:
            return imageNames.count
        case subCarouselView:
            return homeDescriptions.count
        default:
            assert(false, "Not a valid cell")
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var carouselImage = UIImageView()
        
        switch carousel {
        case subCarouselView:
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
            
            let postLabel = UILabel()
            postLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(25))
            postLabel.textAlignment = .justified
            postLabel.numberOfLines = 1
            postLabel.sizeToFit()
            
            let usernameLabel = UILabel()
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
            usernameLabel.textAlignment = .justified
            usernameLabel.numberOfLines = 1
            usernameLabel.text = imageNames[index]
            usernameLabel.sizeToFit()
            
            let profilePicture = UIImageView()
            profilePicture.contentMode = .scaleAspectFill
            profilePicture.translatesAutoresizingMaskIntoConstraints = false
            profilePicture.layer.cornerRadius = 25
            profilePicture.layer.masksToBounds = true
            profilePicture.image = UIImage(named: profileNames[index])?.withRenderingMode(.alwaysOriginal)
            
            carouselImage.addSubview(postLabel)
            carouselImage.addSubview(usernameLabel)
            carouselImage.addSubview(profilePicture)
            
            profilePicture.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: nil, right: nil, paddingTop: 46, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
            postLabel.anchor(top: profilePicture.topAnchor, left: profilePicture.rightAnchor, bottom: nil, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 24, width: 0, height: postLabel.intrinsicContentSize.height)
            usernameLabel.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: usernameLabel.intrinsicContentSize.width, height: usernameLabel.intrinsicContentSize.height)
            
            toggleLike(label: postLabel, index: index)
            
            return carouselImage
        case carouselView:
            carouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 325, height: 400))
            
            carouselImage.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            carouselImage.contentMode = .scaleAspectFill
            carouselImage.layer.cornerRadius = 4
            carouselImage.layer.masksToBounds = true
            carouselImage.isUserInteractionEnabled = true
            
            carouselView.isUserInteractionEnabled = true
            
            let leftButton = UIButton()
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            leftButton.isUserInteractionEnabled = true
            leftButton.addTarget(self, action: #selector(handleLeftTap), for: .touchUpInside)
            
            let rightButton = UIButton()
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            rightButton.isUserInteractionEnabled = true
            rightButton.addTarget(self, action: #selector(handleRightTap), for: .touchUpInside)
            
            let playBackground = PlayView()
            playBackground.layer.cornerRadius = 15
            playBackground.translatesAutoresizingMaskIntoConstraints = false
            playBackground.backgroundColor = .white
            playBackground.layer.masksToBounds = true
            
            let playIcon = UIImageView()
            playIcon.image = #imageLiteral(resourceName: "view-more").withRenderingMode(.alwaysOriginal)
            playIcon.contentMode = .scaleAspectFill
            playIcon.translatesAutoresizingMaskIntoConstraints = false
            
            let backgroundButton = UIButton()
            backgroundButton.backgroundColor = .white
            backgroundButton.translatesAutoresizingMaskIntoConstraints = false
            backgroundButton.layer.cornerRadius = 2
            backgroundButton.clipsToBounds = true
            backgroundButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
            
            let fullscreenLabel = UILabel()
            fullscreenLabel.text = "Full Screen"
            fullscreenLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(25))
            fullscreenLabel.translatesAutoresizingMaskIntoConstraints = false
            
            carouselImage.addSubview(leftButton)
            carouselImage.addSubview(rightButton)
            carouselImage.addSubview(backgroundButton)
            carouselImage.addSubview(fullscreenLabel)
            carouselImage.addSubview(playBackground)
            carouselImage.addSubview(playIcon)
            
            leftButton.anchor(top: carouselImage.topAnchor, left: carouselImage.leftAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            rightButton.anchor(top: carouselImage.topAnchor, left: carouselImage.centerXAnchor, bottom: carouselImage.bottomAnchor, right: carouselImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            backgroundButton.anchor(top: nil, left: leftButton.leftAnchor, bottom: leftButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 100, height: 30)
            fullscreenLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: fullscreenLabel.intrinsicContentSize.width, height: fullscreenLabel.intrinsicContentSize.height)
            fullscreenLabel.centerXAnchor.constraint(equalTo: backgroundButton.centerXAnchor).isActive = true
            fullscreenLabel.centerYAnchor.constraint(equalTo: backgroundButton.centerYAnchor).isActive = true
            playBackground.anchor(top: nil, left: nil, bottom: rightButton.bottomAnchor, right: rightButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 30, height: 30)
            playIcon.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
            playIcon.centerXAnchor.constraint(equalTo: playBackground.centerXAnchor).isActive = true
            playIcon.centerYAnchor.constraint(equalTo: playBackground.centerYAnchor).isActive = true
            return carouselImage
        default:
            return carouselImage
        }
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 0.6
        } else if carousel == subCarouselView {
            return value * 0.6
        }
        
        return value
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if carousel == carouselView {
            homeDelegate?.homeRowScrolled(for: self)
            subCarouselView.scrollOffset = carouselView.scrollOffset
        }
    }
    
    @objc func handleLeftTap(){
        carouselView.scrollToItem(at: cellIndex - 1, animated: true)
        cellIndex = cellIndex - 1
        
        if cellIndex < 0 {
            cellIndex = cellIndex + 1
        }
    }
    
    @objc func handleRightTap(){
        carouselView.scrollToItem(at: cellIndex + 1, animated: true)
        cellIndex = cellIndex + 1
        
        if cellIndex > imageNames.count {
            cellIndex = cellIndex - 1
        }
    }
    
    func setupCarousels(){
        setupStandardCarousel()
        labelSubCarousel()
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let currentIndex = carouselView.currentItemIndex
        cellIndex = currentIndex
    }
    
    func setupStandardCarousel(){
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.type = .invertedTimeMachine
        
        let guide = safeAreaLayoutGuide
        addSubview(carouselView)
        carouselView.anchor(top: topAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 0, height: 412)
    }
    
    func labelSubCarousel(){
        subCarouselView.dataSource = self
        subCarouselView.delegate = self
        subCarouselView.isScrollEnabled = false
        subCarouselView.type = .invertedCylinder
        subCarouselView.backgroundColor = .clear
        subCarouselView.isVertical = true
        
        let guide = safeAreaLayoutGuide
        addSubview(subCarouselView)
        addSubview(optionButton)
        subCarouselView.anchor(top: carouselView.bottomAnchor, left: guide.leftAnchor, bottom: nil, right: guide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        optionButton.anchor(top: nil, left: nil, bottom: subCarouselView.bottomAnchor, right: subCarouselView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 14, paddingRight: 12, width: optionButton.intrinsicContentSize.width, height: optionButton.intrinsicContentSize.height)
    }
}

