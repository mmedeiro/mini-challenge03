//
//  MenuCollectionView.swift
//  MiniChallenge03
//
//  Created by João Vitor dos Santos Schimmelpfeng on 20/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

let reuseIdentifier = "menuImage"

var kImageOriginHeight = CGFloat(100)

class MenuCollectionView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var header : headerReusableView!
    
    var imagens = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
       // self.collectionView!.registerClass(ParallaxViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        imagens.append("calculo")
        self.collectionView.contentInset = UIEdgeInsetsMake(-kImageOriginHeight, 0, 0, 0);
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 14
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ParallaxViewCell
        parallaxCell.frame = CGRect(x: 0, y: parallaxCell.frame.origin.y, width: self.collectionView.frame.width, height: parallaxCell.frame.height)
        parallaxCell.imageView.image = UIImage(named: "calculo")!
        return parallaxCell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        if(kind == UICollectionElementKindSectionHeader)
        {
            var view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! headerReusableView
            view.initialFrame = view.frame
            header = view
            return view
        }
        else
        {
            var view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", forIndexPath: indexPath) as! UICollectionReusableView
            return view
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(scrollView.contentOffset.y < 0)
        {
            header.setContentOffset(scrollView.contentOffset)
        }
        else if(scrollView.contentOffset.y < 20)
        {
            header.returnToContent()
        }
        
        if let visibleCells = collectionView!.visibleCells() as? [ParallaxViewCell]
        {
            for parallaxCell in visibleCells
            {
                var yOffset = ((collectionView!.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }
    
    func rotated(){
        self.collectionView.reloadData()
    }
    

}
