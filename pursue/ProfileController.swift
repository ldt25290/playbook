//
//  ProfileContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ProfileController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let peopleId = "peopleId"
//    let pursuitId = "pursuitId"
//    let challengeId = "challengeId"
    let headerId = "headerId"
    let containerId = "containerId"
    
    
    var user : User?
    var followers : [Follower]?
    let profileService = ProfileServices()
    
    func changeToInterests(){
        let interest = InterestsController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(interest, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = false

        NotificationCenter.default.addObserver(self, selector: #selector(getUser), name: EditProfileController.updateProfileValues, object: nil)
        
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ProfileContainer.self, forCellWithReuseIdentifier: containerId)
//        collectionView?.register(ProfilePursuit.self, forCellWithReuseIdentifier: pursuitId)
//        collectionView?.register(ProfileAdded.self, forCellWithReuseIdentifier: peopleId)
//        collectionView?.register(ProfileChallenge.self, forCellWithReuseIdentifier: challengeId)
        
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 100, right: 0)
//        getUser()
    }
    
    var isForeignAccount : Bool?
    var isDetailView : Bool?
    var userId : String?
    
    @objc func getUser(){
        if isForeignAccount == nil {
            profileService.getAccount { (user) in
                DispatchQueue.main.async {
                    self.user = user
                    self.collectionView?.reloadData()
                }
            }
        } else if isForeignAccount == true {
            getForeignUser()
        }
    }
    
    func getForeignUser(){
        profileService.getForeigntAccount(userId: userId!) { (user) in
            DispatchQueue.main.async {
                self.user = user
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func showFriendsController(){
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        navigationController?.pushViewController(friendsController, animated: true)
    }
    
    func handleFriendsSettings(friendId : String) {
        let customAlert = CustomFriendSettingsView()
        customAlert.userId = friendId
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleSettings() {
        let customAlert = CustomSettingsView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func handleDismiss(){
        if isDetailView == true {
            dismiss(animated: true, completion: nil)
        } else if isDetailView == nil {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func handleEditProfile(){
        let editController = EditProfileController()
        present(editController, animated: true, completion: nil)
    }
    
    func profilePostHeld() {
        
    }
    
    func handleChangeToDetail(pursuitNumber : IndexPath) {
        
    }
}

extension ProfileController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
//        cell.user = user
//        cell.accessProfileController = self
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 60.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 60.0
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
//        switch indexPath.item {
//        case 0:
//            return CGSize(width: view.frame.width, height: 280)
//        case 1:
//            return CGSize(width: view.frame.width, height: 190)
//        default:
//            return CGSize(width: view.frame.width, height: 340)
//        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: containerId, for: indexPath) as! ProfileContainer
        return cell
        
//        switch indexPath.item {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pursuitId, for: indexPath) as! ProfilePursuit
//            return cell
//        case 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleId, for: indexPath) as! ProfileAdded
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeId, for: indexPath) as! ProfileChallenge
//            return cell
//        }
        
    }
}
