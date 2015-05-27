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
var materias = Array<String>()

class MenuCollectionView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var header : headerReusableView!
    
    var imagens = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
       // self.collectionView!.registerClass(ParallaxViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        imagens.append("calculo")
        self.collectionView.contentInset = UIEdgeInsetsMake(-kImageOriginHeight, 0, 0, 0);
        
        materias = [NSLocalizedString("precal",  comment: "pre calculo"), NSLocalizedString("limite",  comment: "limites"), NSLocalizedString("derivada",  comment: "derivada"), NSLocalizedString("integral",  comment: "integral"), NSLocalizedString("calc",  comment: "calculadora"), NSLocalizedString("canvas",  comment: "canvas"), NSLocalizedString("mais",  comment: "outro")]
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
        var parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ParallaxViewCell
        
        if materias[indexPath.row] == NSLocalizedString("canvas",  comment: "canvas"){
            parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier("canvas", forIndexPath: indexPath) as! ParallaxViewCell
        }
        else if materias[indexPath.row] == NSLocalizedString("calc",  comment: "calculadora"){
            parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier("calculadora", forIndexPath: indexPath) as! ParallaxViewCell
        }
        
        
        
        
        parallaxCell.frame = CGRect(x: 0, y: parallaxCell.frame.origin.y, width: self.collectionView.frame.width, height: parallaxCell.frame.height)
        parallaxCell.imageView.image = UIImage(named: "calculo")!
        parallaxCell.title.text = materias[indexPath.row]
        parallaxCell.title.textColor = UIColor.yellowColor()
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var index = self.collectionView.indexPathForCell(sender as! ParallaxViewCell)
    
        if materias[index!.row] == NSLocalizedString("canvas",  comment: "canvas"){
            var cards = segue.destinationViewController as! TestsViewController
        }
        else if materias[index!.row] == NSLocalizedString("calc",  comment: "calculadora"){
            var cards = segue.destinationViewController as! UIViewController
        }
        else{
            var cards = segue.destinationViewController as! CardsViewController
            cards.materia = materias[index!.row]
        }

    }
}
