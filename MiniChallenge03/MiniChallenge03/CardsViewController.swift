//
//  ViewController.swift
//  CardsCollection
//
//  Created by Felipe Marques Ramos on 19/05/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class CardsViewController: UICollectionViewController {
    
    var cards = Array<String>()
    
    
    var stackedLayout = StackedLayout()
    var stackedContentOffset = CGPoint()
    
    
    var exposedLayoutMargin = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
    var exposedItemSize = CGSizeZero
    var exposedTopItemOverLap:CGFloat = 20.0
    var exposedBottomOverLap:CGFloat = 20.0
    var exposedBottomLapCount = 1
    
    
    var exposedItemsAreSelectables = false
    
    private var auxIndex : NSIndexPath?
    
    var exposedIndexPath : NSIndexPath?{
        get{
            return auxIndex
        }
        set(newVal){
            self.setExposedItemIndexPath(newVal)
        }
    }
    
    
    
    func setExposedItemIndexPath(exposedItemIndexPath: NSIndexPath?){
        
        //        if(!exposedItemIndexPath!.isEqual(self.exposedIndexPath)){
        if (exposedIndexPath == nil){
            
            self.collectionView?.selectItemAtIndexPath(exposedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
            if self.collectionView?.collectionViewLayout == stackedLayout {
                self.stackedContentOffset = self.collectionView!.contentOffset
            }
            var exposedLayout = ExposedLayout()
            
            exposedLayout.exposedItemIndex = exposedItemIndexPath!.item
            
            exposedLayout.layoutMargin = self.exposedLayoutMargin
            exposedLayout.itemSize = self.exposedItemSize
            exposedLayout.TopOverLap = self.exposedTopItemOverLap
            exposedLayout.BottomOverLap = self.exposedBottomOverLap
            exposedLayout.BottomLapCount = self.exposedBottomLapCount
            
            self.collectionView!.setCollectionViewLayout(exposedLayout, animated: true)
        }
        else{
            self.collectionView?.deselectItemAtIndexPath(self.exposedIndexPath, animated: true)
            self.stackedLayout.overwriteContOffset = true
            self.collectionView?.setCollectionViewLayout(stackedLayout, animated: true)
            self.stackedLayout.overwriteContOffset = true
        }
        
        self.auxIndex = exposedItemIndexPath
        
        //    }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        cards = ["oopa","olha","esses","melhores","cards","cards","cards","cards","cards","cards","cards"]
        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.title.text = cards[indexPath.row]
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 2
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
//        var cors = [UIColor.redColor(),UIColor.purpleColor(),UIColor.yellowColor(),UIColor.blueColor()]
//        cell.backgroundColor = cors[Int(arc4random_uniform(4))]
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.isEqual(self.exposedIndexPath){
            self.exposedIndexPath = nil
        }
        else if self.exposedIndexPath == nil{
            self.exposedIndexPath = indexPath
            
        }
    }
    
    func rotated(){
        self.collectionView?.reloadData()
    }

    
    
    
}


