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
    
    
    var exposedLayoutMargin = UIEdgeInsetsMake(40.0, 0.0, 0.0, 0.0)
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
        cards = ["oopa","olha","esses","melhores","melhores","melhores","melhores"]
        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! UICollectionViewCell
        
//        cell.layer.cornerRadius = cell.frame.width/16
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        var cors = [UIColor.redColor(),UIColor.purpleColor(),UIColor.yellowColor(),UIColor.blueColor()]
        
        var colorCard1 = UIColor(red: 193/255, green: 15/255, blue: 22/255, alpha: 1.0)
        var colorCard2 = UIColor(red: 38/255, green: 10/255, blue: 106/255, alpha: 1.0)
        var colorCard3 = UIColor(red: 33/255, green: 131/255, blue: 213/255, alpha: 1.0)
        var colorCard4 = UIColor(red: 129/255, green: 123/255, blue: 109/255, alpha: 1.0)
        var colors = Array<UIColor>()
        
        colors = [colorCard1, colorCard2, colorCard3, colorCard4]
        
        var red = CGFloat(255 - indexPath.row*25)/255
        var green = CGFloat(200 - indexPath.row*25)/255
        var blue = CGFloat(150 - indexPath.row*25)/255
        
        
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
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


