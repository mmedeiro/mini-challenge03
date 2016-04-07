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
var materias:[NSDictionary] = []

class MenuCollectionView2: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var header : headerReusableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let font = UIFont(name: "Palatino", size: 25) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        }
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.collectionView.contentInset = UIEdgeInsetsMake(-kImageOriginHeight, 0, 0, 0);
        
        let jsm = JsonManager.sharedInstance;

        materias = jsm.lerMaterias()

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
        return materias.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ParallaxViewCell
        
        parallaxCell.frame = CGRect(x: 0, y: parallaxCell.frame.origin.y, width: self.collectionView.frame.width, height: parallaxCell.frame.height)
        parallaxCell.imageView.image = UIImage(named: "calculo")!
        parallaxCell.title.text = materias[indexPath.row]["nome"] as? String
        return parallaxCell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        if(kind == UICollectionElementKindSectionHeader)
        {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! headerReusableView
            view.initialFrame = view.frame
            header = view
            return view
        }
        else
        {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", forIndexPath: indexPath)
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
                let yOffset = ((collectionView!.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }
    
    func rotated(){
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        let celula = self.collectionView.cellForItemAtIndexPath(indexPath)
        
        if ( materias[indexPath.row]["codigo"] as? String) == "calculadora"{
            self.performSegueWithIdentifier("calculadora", sender: celula)
        }
        else
        {
            self.performSegueWithIdentifier("cards", sender: celula)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let index = self.collectionView.indexPathForCell(sender as! ParallaxViewCell)

        if(segue.identifier == "cards"){
            let cards = segue.destinationViewController as! CartaoController
            cards.materia = materias[index!.row]["codigo"] as? String
        }

    }
}
