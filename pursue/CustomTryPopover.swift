//
//  CustomTryPopover.swift
//  pursue
//
//  Created by Jaylen Sanders on 10/17/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Mixpanel

class CustomTryPopover : UIViewController {
    
    var post : Post? {
        didSet {
            guard let image = post?.thumbnailUrl else { return }
            tryImageView.loadImageUsingCacheWithUrlString(image)
            postDescription.text = post?.description
        }
    }
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    let cellId = "cellId"
    var accessLoginController : LoginController?
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tryLabel : UILabel = {
        let label = UILabel()
        label.text = "Try"
        label.font = UIFont(name: "Lato-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton : UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        return button
    }()
    
    lazy var submitButton : UIButton = {
       let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissBackground : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let tryImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let postDescription : UITextField = {
       let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Description", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let engagementService = EngagementServices()
    let createService = CreateServices()
    
    @objc func handleSubmit(){
        Mixpanel.mainInstance().track(event: "Try on Pursuit submitted")
        
        engagementService.toggleTry(pursuitId: 1, is_tried: 1)
        
        guard let thumbnailUrl = post?.thumbnailUrl, let interestId = post?.interestId else { return }
        createService.sendTry(pursuit_description: postDescription.text, thumbnailUrl: thumbnailUrl, interestId: interestId)
        handleCancel()
    }
    
    func setupPage(){
        alertView.addSubview(cancelButton)
        alertView.addSubview(tryLabel)
        alertView.addSubview(tryImageView)
        alertView.addSubview(postDescription)
        alertView.addSubview(submitButton)
        
        tryLabel.anchor(top: alertView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: tryLabel.intrinsicContentSize.width, height: tryLabel.intrinsicContentSize.height)
        tryLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        cancelButton.anchor(top: nil, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 120, height: 34)
        cancelButton.centerYAnchor.constraint(equalTo: tryLabel.centerYAnchor).isActive = true
        tryImageView.anchor(top: tryLabel.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 32, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 120, height: 140)
        postDescription.anchor(top: tryLabel.bottomAnchor, left: tryImageView.rightAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        postDescription.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        submitButton.anchor(top: nil, left: alertView.leftAnchor, bottom: alertView.safeAreaLayoutGuide.bottomAnchor, right: alertView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 18, paddingRight: 12, width: 0, height: 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alertView)
        view.addSubview(dismissBackground)
        
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        setupPage()
        dismissBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: alertView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
}
