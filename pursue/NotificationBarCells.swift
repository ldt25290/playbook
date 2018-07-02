//
//  NotificationBarCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 6/28/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class NotificationBarCells : UICollectionViewCell {
    
    lazy var selectNotification : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            selectNotification.font = isHighlighted ?  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
            selectNotification.textColor = isHighlighted ? .black : .gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectNotification.font = isSelected ? UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25))
            selectNotification.textColor = isSelected ? .black : .gray
        }
    }
    
    func setupView(){
        addSubview(selectNotification)
        
        selectNotification.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: selectNotification.intrinsicContentSize.width, height: selectNotification.intrinsicContentSize.height)
        selectNotification.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}