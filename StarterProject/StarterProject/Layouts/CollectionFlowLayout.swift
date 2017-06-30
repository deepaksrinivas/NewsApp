//
//  ListFlowLayout.swift
//  CollectionTypes
//
//  Created by Srinivas, Deepak - Deepak on 6/20/17.
//  Copyright © 2017 Lowes. All rights reserved.
//

import UIKit

enum CollectionType: String {
    case list = "list"
    case grid = "grid"
    case huge = "huge"
}

class CollectionFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate let listItemHeight: CGFloat = 100
    fileprivate let gridItemHeight: CGFloat = 150
    fileprivate var collectionType: CollectionType = .list
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    convenience init(type: CollectionType) {
        self.init()
        self.collectionType = type
    }
    
    func setupLayout() {
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    func getSize() -> CGSize {
        var size = CGSize.zero
        switch collectionType {
            case .list:
                size = CGSize(width: collectionView!.frame.size.width, height: listItemHeight)
                break
            case .grid:
                size = CGSize(width: (collectionView!.frame.size.width / 2), height: gridItemHeight)
                break
            case .huge:
                size = CGSize(width: collectionView!.frame.size.width, height: (collectionView!.frame.size.height - 10))
                break
        }
        return size
    }
    
    func setSize() {
        switch collectionType {
            case .list:
                self.itemSize = CGSize(width: collectionView!.frame.size.width, height: listItemHeight)
                break
            case .grid:
                self.itemSize = CGSize(width: (collectionView!.frame.size.width / 2), height: gridItemHeight)
                break
            case .huge:
                self.itemSize = CGSize(width: collectionView!.frame.size.width, height: (collectionView!.frame.size.height - 10))
                break
        }
    }
    
    override var itemSize: CGSize {
        get {
            return getSize()
        }
        set {
            setSize()
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}

class ArticleCollectionFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate let listItemHeight: CGFloat = 280
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumLineSpacing = 0
        minimumInteritemSpacing = 10
    }
    
    func getSize() -> CGSize {
        let size = CGSize(width: collectionView!.frame.size.width, height: listItemHeight)
        return size
    }
    
    func setSize() {
        self.itemSize = CGSize(width: collectionView!.frame.size.width, height: listItemHeight)
    }
    
    override var itemSize: CGSize {
        get {
            return getSize()
        }
        set {
            setSize()
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
