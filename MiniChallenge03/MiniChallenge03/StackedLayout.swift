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
    var fillHeight = false
    var alwaysBounce = false
    var overwriteContOffset = false
    var filling = false
    var contentOffset = CGPoint()
    var movingIndexPath = NSIndexPath()
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
        
        var tops = self.topReveal * CGFloat(self.collectionView!.numberOfItemsInSection(0))
        
        var contentSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds), self.layoutMargin.top + tops + self.layoutMargin.bottom - self.collectionView!.contentInset.bottom)
        
        return contentSize
        
    }
    
    override func prepareLayout() {
        self.collectionViewContentSize()
        
        var itemReveal = self.topReveal
        
        if self.filling{
            
            var size = CGRectGetHeight(self.collectionView!.bounds) - self.layoutMargin.top - self.layoutMargin.bottom - self.collectionView!.contentInset.top - self.collectionView!.contentInset.bottom
            
            itemReveal = floor( size / CGFloat(self.collectionView!.numberOfItemsInSection(0) ))
            
            
        }
        
        if CGSizeEqualToSize(itemSize, CGSizeZero){
            itemSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds) - self.layoutMargin.left - self.layoutMargin.right, CGRectGetHeight(self.collectionView!.bounds) - self.layoutMargin.top - self.layoutMargin.bottom - self.collectionView!.contentInset.top - self.collectionView!.contentInset.bottom)
        }
        
        
        var contenOffseto = CGPoint()
        if overwriteContOffset{
            contenOffseto =  self.contentOffset
        }
        else{
            contenOffseto = self.collectionView!.contentOffset
        }
        
        var layoutAttributes = Dictionary<NSIndexPath,UICollectionViewLayoutAttributes>()
        var previousTopOverLappingAttributes = Array<UICollectionViewLayoutAttributes>()
        var itemCount = self.collectionView?.numberOfItemsInSection(0)
        
        
        var  firstCompressingItem = -1
        
        
        for var item = 0; item < itemCount; item=item+1{
            
            var index = NSIndexPath(forItem: item, inSection: 0)
            var att = UICollectionViewLayoutAttributes(forCellWithIndexPath: index)
            
            att.zIndex = item
            
            var loc = itemReveal * CGFloat(item)
            
            att.frame = CGRectMake(self.layoutMargin.left, self.layoutMargin.top + loc, itemSize.width, itemSize.height)

            firstCompressingItem = -1
            
            layoutAttributes[index] = att
            
        }
        
        self.layoutAttributes = layoutAttributes
        
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = NSMutableArray()
        
        for item in self.layoutAttributes{
            var att = item.1
            if CGRectIntersectsRect(rect, att.frame){
                layoutAttributes.addObject(att)
            }
        }
        
        return layoutAttributes as [AnyObject]
        
    }
    
    override func  layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.layoutAttributes[indexPath]
        
    }
}
