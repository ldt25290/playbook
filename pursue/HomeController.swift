//
//  HomeRowContainer.swift
//  pursue
//
//  Created by Jaylen Sanders on 11/27/17.
//  Copyright © 2017 Glory. All rights reserved.
//

import UIKit
import Hero
import KWTransition
import Motion

class HomeController : UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let labelId = "labelId"
    let pursuitId = "pursuitId"
    let postId = "postId"
    let myId = "myId"

    var isFirstLaunch = false
    var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"]
    
    let imageName = [#imageLiteral(resourceName: "health"), #imageLiteral(resourceName: "fashion-design"), #imageLiteral(resourceName: "ferrari-f70"), #imageLiteral(resourceName: "ferrari")]
    let userPhotos = [#imageLiteral(resourceName: "clean-3"),#imageLiteral(resourceName: "clean-2"),#imageLiteral(resourceName: "comment-2"), #imageLiteral(resourceName: "comment-6")]
    let backgroundFill = UIView()
    let homeServices = HomeServices()
    let detailController = PostDetailController()
    
    let transition = SearchPopAnimation()
    
    func goToProfile(){
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(profile, animated: true)
    }
    

    func setupCollectionView(){
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(HomePostCells.self, forCellWithReuseIdentifier: postId)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    func scrollCollectionView(shiftTo : IndexPath){
        collectionView?.selectItem(at: shiftTo, animated: true, scrollPosition: .centeredHorizontally)
        collectionView?.reloadData()
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            let currentpage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
//            let cellIndexPath = IndexPath(row: currentpage, section: 0)
//            labelCollectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .centeredVertically)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        if UserDefaults.standard.value(forKey: "homeIntroPopover") == nil {
            setupIntroView()
        } else {
            dismissHomePopover()
        }
        isMotionEnabled = true
//
//        transition.dismissCompletion = {
//            self.homeHeaderInstance.isHidden = false
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup View
    
    func goToNotifications(){
        let view = NotificationsContainer(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(view, animated: true)
    }
    
    func goToSearchController(){
        let searchView = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        searchView.searchBar.becomeFirstResponder()
        present(searchView, animated: true, completion: nil)
    }
    
    
    
    func postHeld(transitionId : String) {
        
    }
    
//    func handleChangeToDetail(viewType : String, transitionId : String) {
//        switch viewType {
//        case "isPursuitDetail":
//            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
////            detail.imageView.heroID = transitionId
//            detail.standardView()
//            navigationController?.pushViewController(detail, animated: true)
////            navigationController?.present(detail, animated: true, completion: nil)
//        case "isChallengeDetail":
//            let detail = PursuitsDetailController(collectionViewLayout: UICollectionViewFlowLayout())
////            detail.imageView.heroID = transitionId
//            detail.challengeView()
//            navigationController?.pushViewController(detail, animated: true)
////            navigationController?.present(detail, animated: true, completion: nil)
//        default:
//            assert(false, "Not a valid view type")
//        }
//    }
    
    func handleChangeToDetail(transitionId : String){
        let detail = PostDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        detail.imageView.motionIdentifier = transitionId
//        detail.imageView.hero.id = transitionId
        present(detail, animated: true, completion: nil)
    }
    
    // MARK: - Show first load popover
    
    lazy var alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var backgroundView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissHomePopover))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var homeIntroLabel : UILabel = {
       let label = UILabel()
        label.text = "View Pursuits"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.init(25))
        return label
    }()
    
    lazy var pursuitsDescription : UILabel = {
       let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Stay inspired and learn steps and principles that can help you on your journey.")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var gotItButton : UIButton = {
       let button = UIButton()
        button.setTitle("Got It", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .justified
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(dismissHomePopover), for: .touchUpInside)
        return button
    }()
    
    let underlineView = UIView()
    
    @objc func dismissHomePopover(){
        UserDefaults.standard.set("true", forKey: "homeIntroPopover")

        backgroundView.isHidden = true
        alertView.isHidden = true
        homeIntroLabel.isHidden = true
        pursuitsDescription.isHidden = true
        underlineView.isHidden = true
        gotItButton.isHidden = true
        
        self.tabBarController?.tabBar.layer.zPosition = 0
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupIntroView() {
        self.tabBarController?.tabBar.layer.zPosition = -1
        self.tabBarController?.tabBar.isHidden = true
        alertView.layer.cornerRadius = 15
        setupIntroConstraints()
        animateView()
    }
    
    func setupIntroConstraints(){
        underlineView.backgroundColor = .lightGray
        
        view.addSubview(backgroundView)
        view.addSubview(alertView)
        view.addSubview(homeIntroLabel)
        view.addSubview(pursuitsDescription)
        view.addSubview(underlineView)
        alertView.addSubview(gotItButton)
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        alertView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
        alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        homeIntroLabel.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: homeIntroLabel.intrinsicContentSize.width, height: homeIntroLabel.intrinsicContentSize.height)
        pursuitsDescription.anchor(top: homeIntroLabel.bottomAnchor, left: homeIntroLabel.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
        underlineView.anchor(top: pursuitsDescription.bottomAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0.5)
        gotItButton.anchor(top: underlineView.bottomAnchor, left: underlineView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: gotItButton.intrinsicContentSize.width, height: gotItButton.intrinsicContentSize.height)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    let homeHeaderInstance = HomeHeader()
}

extension HomeController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height / 2) + 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeHeader
        header.accessHomeController = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath) as! HomePostCells
        cell.accessHomeController = self
        cell.photo.image = imageName[indexPath.item]
        cell.userPhoto.image = userPhotos[indexPath.item]
        return cell
    }
    
}
