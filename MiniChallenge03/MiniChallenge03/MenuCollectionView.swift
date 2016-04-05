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
        
        if let font = UIFont(name: "Palatino", size: 25) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        }
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuCollectionView.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        imagens.append("calculo")
        self.collectionView.contentInset = UIEdgeInsetsMake(-kImageOriginHeight, 0, 0, 0);
        
        materias = [NSLocalizedString("precal",  comment: "pre calculo"), NSLocalizedString("limite",  comment: "limites"), NSLocalizedString("derivada",  comment: "derivada"), NSLocalizedString("integral",  comment: "integral"),NSLocalizedString("mais",  comment: "outro"), NSLocalizedString("calc",  comment: "calculadora")]
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
        parallaxCell.title.text = materias[indexPath.row]
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
        if materias[indexPath.row] == NSLocalizedString("canvas",  comment: "canvas")
        {
            self.performSegueWithIdentifier("tests", sender: celula)
            
        }
        else if materias[indexPath.row] == NSLocalizedString("calc",  comment: "calculadora"){
            self.performSegueWithIdentifier("calculadora", sender: celula)
        }
        else
        {
            self.performSegueWithIdentifier("cards", sender: celula)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let index = self.collectionView.indexPathForCell(sender as! ParallaxViewCell)
    
        if (segue.identifier == "tests")
        {
            
        }
        else if(segue.identifier == "calculadora"){
        }
        else{
            let cards = segue.destinationViewController as! CardsViewController
            cards.materia = materias[index!.row]
        }

    }
}
