//
//  PhotoLibrary.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/21/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Hero
import Photos
import SwiftyCam

private extension UICollectionView {
    func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
}

class PhotoLibrary : SwiftyCamViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoDelegate, SwiftyCamViewControllerDelegate {
    
    var fetchResult: PHFetchResult<PHAsset>!
    
    fileprivate var thumbnailSize: CGSize!
    fileprivate let imageManager = PHCachingImageManager()
    fileprivate var previousPreheatRect = CGRect.zero
    
    let cellId = "cellId"
    
    lazy var captureButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(white: 0.7, alpha: 0.5)
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var linkButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "link").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleLink), for: .touchUpInside)
        return button
    }()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var photoLibraryButton : UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLibrary), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLibrary(){
        let libraryController = PhotoLibrary()
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        navigationController?.pushViewController(libraryController, animated: true)
    }
    
    @objc func handleCamera(){
        let selectCameraController = SelectCameraController()
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        navigationController?.pushViewController(selectCameraController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isHeroEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(PhotoLibraryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHeroEnabled = true
        setupView()
        
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
    }
    
    func setupView(){
        view.addSubview(collectionView)
        view.addSubview(captureButton)
        view.addSubview(photoLibraryButton)
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        captureButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 50, height: 50)
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoLibraryButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 28, height: 28)
        photoLibraryButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor).isActive = true
        setupTopOptions()
        
    }
    
    func setupTopOptions(){
        view.addSubview(cancelButton)
        view.addSubview(linkButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        linkButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 17, height: 15)
       
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLink(){
        let customAlert = CustomLinkView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.showDetailViewController(customAlert, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 20) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 6, 0, 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    var imageAsset : PHAsset?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = fetchResult.object(at: indexPath.item)
        self.imageAsset = asset
        let targetSize = CGSize(width: 200, height: 200)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoLibraryCell
        cell.delegate = self
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (image, _) in
            if cell.representedAssetIdentifier == asset.localIdentifier && image != nil {
                cell.imageView.image = image
                self.photoLibraryButton.setImage(image, for: .normal)
                
                if asset.duration == 0 {
                    cell.timeLabel.text = ""
                } else {
                    cell.timeLabel.text = String(format: "%02d:%02d",Int((asset.duration / 60)),Int(asset.duration) % 60)
                }
                
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCachedAssets()
    }
    
    fileprivate func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }
    
    fileprivate func updateCachedAssets() {
        // Update only if the view is visible.
        guard isViewLoaded && view.window != nil else { return }
        
        // The preheat window is twice the height of the visible rect.
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)
        
        // Update only if the visible area is significantly different from the last preheated area.
        let delta = abs(preheatRect.midY - previousPreheatRect.midY)
        guard delta > view.bounds.height / 3 else { return }
        
        // Compute the assets to start caching and to stop caching.
        let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
        let addedAssets = addedRects
            .flatMap { rect in collectionView.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        let removedAssets = removedRects
            .flatMap { rect in collectionView.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        
        // Update the assets the PHCachingImageManager is caching.
        let targetSize = CGSize(width: 200, height: 200)
        imageManager.startCachingImages(for: addedAssets,
                                        targetSize: targetSize, contentMode: .aspectFit, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: targetSize, contentMode: .aspectFit, options: nil)
        
        // Store the preheat rect to compare against in the future.
        previousPreheatRect = preheatRect
    }
    
    fileprivate func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added: [CGRect], removed: [CGRect]) {
        if old.intersects(new) {
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY,
                                 width: new.width, height: new.maxY - old.maxY)]
            }
            if old.minY > new.minY {
                added += [CGRect(x: new.origin.x, y: new.minY,
                                 width: new.width, height: old.minY - new.minY)]
            }
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY,
                                   width: new.width, height: old.maxY - new.maxY)]
            }
            if old.minY < new.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY,
                                   width: new.width, height: new.minY - old.minY)]
            }
            return (added, removed)
        } else {
            return ([new], [old])
        }
    }
}

extension PhotoLibrary : PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: fetchResult)
            else { return }
        
        // Change notifications may be made on a background queue. Re-dispatch to the
        // main queue before acting on the change as we'll be updating the UI.
        DispatchQueue.main.sync {
            // Hang on to the new fetch result.
            fetchResult = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                // If we have incremental diffs, animate them in the collection view.
                self.collectionView.performBatchUpdates({
                    // For indexes to make sense, updates must be in this order:
                    // delete, insert, reload, move
                    if let removed = changes.removedIndexes, !removed.isEmpty {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, !inserted.isEmpty {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let changed = changes.changedIndexes, !changed.isEmpty {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        self.collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                // Reload the collection view if incremental diffs are not available.
                collectionView.reloadData()
            }
            resetCachedAssets()
        }
    }
    
}

extension PhotoLibrary {
    
    func didSelect(for cell: PhotoLibraryCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let asset = fetchResult.object(at: indexPath.item)
        let targetSize = CGSize(width: 200, height: 200)

        if cell.timeLabel.text == "" {
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (image, _) in
                guard let selectedImage = image else { return }
                self.swiftyCam(self, didTake: selectedImage)
            }
        } else {
                let options: PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .original
                self.imageManager.requestAVAsset(forVideo: asset, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                    DispatchQueue.main.sync {
                        if let urlAsset = asset as? AVURLAsset {
                            let localVideoUrl: URL = urlAsset.url as URL
                            self.swiftyCam(self, didFinishProcessVideoAt: localVideoUrl)
                        } else {
                            print("Failed")
                        }
                    }
                })
                
            }
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let newVC = PhotoViewController(image: photo)
        guard let viewAsset = imageAsset else { return }
        newVC.asset = viewAsset
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType =  .fade
        navigationController?.pushViewController(newVC, animated: true)
    }
}

extension PhotoLibrary : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 24, height: .infinity)
        
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            constraint.constant = estimatedSize.height
        }
    }
}

