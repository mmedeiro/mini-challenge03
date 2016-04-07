//
//  ViewController.swift
//  CardsCollection
//
//  Created by Felipe Marques Ramos on 19/05/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class CartaoController: UICollectionViewController {
    

    @IBOutlet var titulo: UINavigationItem!
    
    var materia: String?
    var cards:[Card] = []
    
    var tap: UITapGestureRecognizer?
    
//    var conteudoPreCalculoA = Array<String>()
//    var conteudoPreCalculoB = Array<String>()
//    var conteudoLimitesA = Array<String>()
//    var conteudoLimitesB = Array<String>()
//    var conteudoDerivadasA = Array<String>()
//    var conteudoDerivadasB = Array<String>()
//    var conteudoIntegraisA = Array<String>()
//    var conteudoIntegraisB = Array<String>()
//    var conteudoCalculadoraA = Array<String>()
//    var conteudoCalculadoraB = Array<String>()
//    var conteudoTabsA = Array<String>()
//    var conteudoTabsB = Array<String>()
//
//    
//    var conteudoImagePreCalculo = Array<String>()
//    var conteudoImageLimite = Array<String>()
//    var conteudoImageDerivada = Array<String>()
//    var conteudoImageIntegral = Array<String>()
//    var conteudoImageCalculadora = Array<String>()
//    var conteudoImageTabs = Array<String>()
//    
//    var cardsPreCalculo = Array<Card>()
//    var cardsLimites = Array<Card>()
//    var cardsDerivadas = Array<Card>()
//    var cardsIntegrais = Array<Card>()
//    var cardsCalculadora = Array<Card>()
//    var cardsTabs = Array<Card>()
    
    
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
        
        if (exposedIndexPath == nil){
            
            self.collectionView?.selectItemAtIndexPath(exposedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
            if self.collectionView?.collectionViewLayout == stackedLayout {
                self.stackedContentOffset = self.collectionView!.contentOffset
            }
            let exposedLayout = ExposedLayout()
            
            exposedLayout.exposedItemIndex = exposedItemIndexPath!.item
            
            exposedLayout.layoutMargin = self.exposedLayoutMargin
            exposedLayout.itemSize = self.exposedItemSize
            exposedLayout.TopOverLap = self.exposedTopItemOverLap
            exposedLayout.BottomOverLap = self.exposedBottomOverLap
            exposedLayout.BottomLapCount = self.exposedBottomLapCount
            
            self.collectionView!.setCollectionViewLayout(exposedLayout, animated: true)
        }
        else{
            self.collectionView?.deselectItemAtIndexPath(self.exposedIndexPath!, animated: true)
            self.stackedLayout.overwriteContOffset = true
            self.collectionView?.setCollectionViewLayout(stackedLayout, animated: true)
            self.stackedLayout.overwriteContOffset = true
        }
        
        self.auxIndex = exposedItemIndexPath
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self , action: #selector(CartaoController.handleTap))
        tap?.numberOfTapsRequired = 2
        
        self.collectionView?.addGestureRecognizer(tap!)
        
        self.titulo.title = materia!
        
        
        if let font = UIFont(name: "Palatino", size: 25) {
            let nav = self.navigationController?.navigationBar
            nav?.titleTextAttributes = [NSFontAttributeName: font]
        }
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CartaoController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        self.populaCards()
        //self.populaConteudo()
        
//        materias = [NSLocalizedString("precal",     comment: "pre calculo"),
//                    NSLocalizedString("limite",     comment: "limites"),
//                    NSLocalizedString("derivada",   comment: "derivada"),
//                    NSLocalizedString("integral",   comment: "integral"),
//                    NSLocalizedString("mais",       comment: "outro"),
//                    NSLocalizedString("calc",       comment: "calculadora"),
//                    ]
        
        
//        cardsMateria = [materias[0] : cardsPreCalculo , materias[1] : cardsLimites , materias[2] : cardsDerivadas, materias[3] : cardsIntegrais, materias[4] : cardsTabs, materias[5] : cardsCalculadora]
        

        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
        
        cell.title.text = cards[indexPath.row].titulo!
        
        cell.textViewConteudo.attributedText = cards[indexPath.row].conteudo!
        
        if exposedIndexPath == indexPath{
            cell.textViewConteudo.hidden = false
        }
        else{
            cell.textViewConteudo.hidden = true
        }

        cell.backgroundColor = self.geraCorCards(indexPath,corInicial: 220)
        cell.layer.borderColor = self.geraCorCards(indexPath, corInicial: 200).CGColor
        
        if cell.title.text == "Teste" {
            cell.buttonTest.hidden = false
        }
        else{
            cell.buttonTest.hidden = true
        }
        cell.updateConstraints()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CardCollectionViewCell
        
        if indexPath.isEqual(self.exposedIndexPath){
            self.exposedIndexPath = nil
            cell.textViewConteudo.hidden = true
        }
        else if self.exposedIndexPath == nil{
            self.exposedIndexPath = indexPath
            cell.textViewConteudo.hidden = false
        }
    }
    
    func rotated()
    {
        self.collectionView!.reloadData()
        //self.view.setNeedsLayout()
        
    }

    //MARK: Gesture
    
    @IBAction func handleTap() {
        print("aquele tap")
        if self.exposedIndexPath != nil {
            self.collectionView(self.collectionView!, didSelectItemAtIndexPath: exposedIndexPath!)
        }

    }
    
    //MARK: CARDS E CONTEUDO
    
    
    private func populaCards(){
        let jsm = JsonManager.sharedInstance
        let materiaCard = jsm.lerConteudo(materia!)
        
        for conteudo in materiaCard{
            cards.append(Card(titulo: conteudo.0, conteudo: conteudo.1))
        }
    }

    private func geraCorCards(index: NSIndexPath, corInicial: Int)->UIColor{

        let red = CGFloat(corInicial - index.row*15)/255
        let green = CGFloat(corInicial - index.row*15)/255
        let blue = CGFloat(corInicial - index.row*15)/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
  
}


