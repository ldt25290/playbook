//
//  HomeInterestsCells.swift
//  pursue
//
//  Created by Jaylen Sanders on 1/18/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

class HomeInterestsCells : UICollectionViewCell {
    
    lazy var selectInterests : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            selectInterests.font = isHighlighted ?  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 16)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectInterests.font = isSelected ? UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 25)) : UIFont.systemFont(ofSize: 16)
        }
    }
    
    func setupView(){
        addSubview(selectInterests)
        
        selectInterests.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: selectInterests.intrinsicContentSize.width, height: selectInterests.intrinsicContentSize.height)
        selectInterests.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectInterests.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
