//
//  StackedLayout.swift
//  CardsCollection
//
//  Created by Felipe Marques Ramos on 20/05/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class StackedLayout: UICollectionViewLayout {
    
    var layoutMargin = UIEdgeInsetsMake(5, 0.0, 0.0, 0.0)
    var itemSize = CGSizeZero
    var topReveal:CGFloat = 100.0
    var bounceFactor:CGFloat = 0.2
    var overwriteContOffset = false
    var contentOffset = CGPoint()
    var layoutAttributes = Dictionary<NSIndexPath,UICollectionViewLayoutAttributes>()
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        if self.overwriteContOffset{
            return self.contentOffset
        }
        return proposedContentOffset
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func  collectionViewContentSize() -> CGSize {
        
        let tops = self.topReveal * CGFloat(self.collectionView!.numberOfItemsInSection(0))
        
        let contentSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds), self.layoutMargin.top + tops + self.layoutMargin.bottom - self.collectionView!.contentInset.bottom)
        
        return contentSize
        
    }
    
    override func prepareLayout() {
        self.collectionViewContentSize()

        if CGSizeEqualToSize(itemSize, CGSizeZero){
            itemSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds) - self.layoutMargin.left - self.layoutMargin.right, CGRectGetHeight(self.collectionView!.bounds) - self.layoutMargin.top - self.layoutMargin.bottom - self.collectionView!.contentInset.top - self.collectionView!.contentInset.bottom)
        }

        
        var layoutAttributes = Dictionary<NSIndexPath,UICollectionViewLayoutAttributes>()
        let itemCount = self.collectionView!.numberOfItemsInSection(0)
        
        for item in 0...itemCount-1{
            let index = NSIndexPath(forItem: item, inSection: 0)
            let att = UICollectionViewLayoutAttributes(forCellWithIndexPath: index)
            
            att.zIndex = item
            
            let loc = topReveal * CGFloat(item)
            
            att.frame = CGRectMake(self.layoutMargin.left, self.layoutMargin.top + loc, itemSize.width, itemSize.height)
            
            layoutAttributes[index] = att
        }

        self.layoutAttributes = layoutAttributes
        
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for item in self.layoutAttributes{
            let att = item.1
            if CGRectIntersectsRect(rect, att.frame){
                layoutAttributes.append(att)
            }
        }
        
        return layoutAttributes
        
    }
    
    override func  layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributes[indexPath]
        
    }
}
