//
//  ViewController.swift
//  CardsCollection
//
//  Created by Felipe Marques Ramos on 19/05/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class CardsViewController: UICollectionViewController {
    
    var materia: String?
    var cardsMateria = Dictionary<String,Array<String>>()
    var cardsLimites = Array<String>()
    var cardsDerivadas = Array<String>()
    var cardsIntegrais = Array<String>()
    var conteudo = Array<String>()
    
    
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
        
        print(materia)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        
        
        cardsLimites = [NSLocalizedString("limite1",  comment: "pre calculo"),NSLocalizedString("limite2",  comment: "pre calculo"),NSLocalizedString("limite3",  comment: "pre calculo"),NSLocalizedString("limite4",  comment: "pre calculo"),NSLocalizedString("limite5",  comment: "pre calculo"),NSLocalizedString("limite6",  comment: "pre calculo"),NSLocalizedString("limite7",  comment: "pre calculo")]
        cardsDerivadas = ["O que é?", "Definição", "Notações", "Teste"]
        cardsIntegrais = ["O que é?", "Definição", "Propriedades Integrais Indefinidas", "Métodos", "Teste"]
        conteudo = ["Limites são a principal base de construção para os cálculos. Muitas vezes, uma função pode ser indefinida em um certo ponto, mas podemos pensar sobre o que a função se aproxima conforme chega cada vez mais perto deste ponto (este é o limite). Outras vezes, a função poderá estar definida em um certo ponto, mas poderá se aproximar de um limite diferente. São muitas as vezes nas quais o valor da função é o mesmo do limite em um ponto. De qualquer forma, este é um recurso muito útil conforme começamos a pensar sobre uma inclinação de uma reta tangente a uma curva.", "", "", "", "", "", "", ""]
        
        materias = [NSLocalizedString("precal",  comment: "pre calculo"), NSLocalizedString("limite",  comment: "limites"), NSLocalizedString("derivada",  comment: "derivada"), NSLocalizedString("integral",  comment: "integral"), NSLocalizedString("calc",  comment: "calculadora"), NSLocalizedString("canvas",  comment: "canvas"), NSLocalizedString("mais",  comment: "outro")]
        cardsMateria = [materias[0] : cardsLimites , materias[1] : cardsLimites , materias[2] : cardsDerivadas, materias[3] : cardsIntegrais]
        
        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
        var arr = cardsMateria[materia!]!
        
        cell.title.text = arr[indexPath.row]
        cell.textViewConteudo.text = conteudo [indexPath.row]

        var red = CGFloat(255 - indexPath.row*25)/255
        var green = CGFloat(200 - indexPath.row*25)/255
        var blue = CGFloat(150 - indexPath.row*25)/255
        
        
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        if cell.title.text == "Teste" {
            cell.buttonTest.hidden = false
        }
        else{
            cell.buttonTest.hidden = true
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var arr = cardsMateria[materia!]!
        return arr.count
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


