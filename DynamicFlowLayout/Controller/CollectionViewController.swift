//
//  CollectionViewController.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 19/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewController: UICollectionViewController {
    var playerImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewInsets()
        setupLayout()

        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
    }
    
    //MARK: private
    
    private func setupCollectionViewInsets() {
        collectionView!.backgroundColor = .clear
        collectionView!.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 5,
            right: 5
        )
    }
    
    private func setupLayout() {
        let layout: Layout = {
            if let layout = collectionViewLayout as? Layout {
                return layout
            }
            let layout = Layout()
            
            collectionView?.collectionViewLayout = layout
            
            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return playerImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellID", for: indexPath) as! CollectionViewCell
        cell.imageView.image = playerImages[indexPath.item]
        return cell
    
    }
    
}

extension CollectionViewController: LayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        return playerImages[indexPath.item].height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {

        return 0
    }
}
