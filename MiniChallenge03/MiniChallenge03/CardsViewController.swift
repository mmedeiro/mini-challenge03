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
    var cardsPreCalculo = Array<String>()
    var cardsLimites = Array<String>()
    var cardsDerivadas = Array<String>()
    var cardsIntegrais = Array<String>()
    var conteudo = Array<String>()
    var conteudoLimites = Array<String>()
    
    
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
        
        
        cardsPreCalculo = [NSLocalizedString("precal1",  comment: "pre calculo"),
                           NSLocalizedString("precal2",  comment: "pre calculo"),
                           NSLocalizedString("precal3",  comment: "pre calculo"),
                           NSLocalizedString("precal4",  comment: "pre calculo")]
        
        cardsLimites = [NSLocalizedString("limite1",  comment: "limite"),
                        NSLocalizedString("limite2",  comment: "limite"),
                        NSLocalizedString("limite3",  comment: "limite"),
                        NSLocalizedString("limite4",  comment: "limite"),
                        NSLocalizedString("limite5",  comment: "limite"),
                        NSLocalizedString("limite6",  comment: "limite"),
                        NSLocalizedString("limite7",  comment: "limite")]
        
        cardsDerivadas = [NSLocalizedString("derivada1",  comment: "derivada"),
                          NSLocalizedString("derivada2",  comment: "derivada"),
                          NSLocalizedString("derivada3",  comment: "derivada"),
                          NSLocalizedString("derivada4",  comment: "derivada")]
        
        
        cardsIntegrais = [NSLocalizedString("integral1",  comment: "integral"),
                          NSLocalizedString("integral2",  comment: "integral"),
                          NSLocalizedString("integral3",  comment: "integral"),
                          NSLocalizedString("integral4",  comment: "integral"),
                          NSLocalizedString("integral5",  comment: "integral")]
        
        
        conteudoLimites = ["Limites são a principal base de construção para os cálculos.\nMuitas vezes, uma função pode ser indefinida em um certo ponto, mas podemos pensar sobre o que a função se aproxima conforme chega cada vez mais perto deste ponto (este é o limite). Outras vezes, a função poderá estar definida em um certo ponto, mas poderá se aproximar de um limite diferente. São muitas as vezes nas quais o valor da função é o mesmo do limite em um ponto. De qualquer forma, este é um recurso muito útil conforme começamos a pensar sobre uma inclinação de uma reta tangente a uma curva.",
            "Seja f uma função definida num intervalo aberto contendo o ponto a, podendo não estar definida no ponto a. Seja b um número real. Diz-se que o limite de f(x) quando x tende para a é b , se e só se, para todo o ε > 0 podemos encontrar um número δ > 0 tal que, para todo o x do domínio de f, se x é tal que 0<x−a<δ então|f (x) − b|< ε",
            "1) O limite da soma é a soma dos limites \n \n2) O limite da diferença é a diferença dos limites \n \n3) O limite do produto é o produto dos limites \n \n4) O limite do quociente é o quociente dos limites, desde que o denominador não seja zero \n \n5) O limite de uma constante é a propria constante \n \n6) O limite de uma função elevada a n é equivalente ao limite elevado a n desta função \n \n7) O limite da raiz enésima de uma função é equivalente a raiz enésima do limite dessa função\n \n8) O limite do logaritmo natural de uma função é equivalente ao logaritmo natural dessa função \n \n9) O limite de e elevado a uma função é equivalente a ë elevado ao limite dessa função \n \n10) O limite do seno de uma função é equivalente ao seno do limite dessa função", "1) 0 ÷ 0 \n \n2) ∞ - ∞ \n \n3) 0 x ∞ \n \n4) ∞ ÷ ∞ \n \n5) 0 ⁰ \n \n6) 1 ⁰⁰ \n \n7) ∞ ⁰ ", "Quando examinamos  estamos pensando que , isto é, x se aproxima de a, por valores maiores ou menores que a. Entretanto, podemos fazer x se aproximar de a apenas por valores maiores do que a. Nesse caso, dizemos que x tende a a pela direita e indicamos. De modo análogo, podemos fazer x se aproximar de a apenas por valores menores do que a. Nesse caso, dizemos que x tende a a pela esquerda e indicamos .Existe  se e somente se ambos os limites laterais são iguais.", "", "", ""]
        
        materias = [NSLocalizedString("precal",     comment: "pre calculo"),
                    NSLocalizedString("limite",     comment: "limites"),
                    NSLocalizedString("derivada",   comment: "derivada"),
                    NSLocalizedString("integral",   comment: "integral"),
                    NSLocalizedString("calc",       comment: "calculadora"),
                    NSLocalizedString("canvas",     comment: "canvas"),
                    NSLocalizedString("mais",       comment: "outro")]
        
        
        cardsMateria = [materias[0] : cardsLimites , materias[1] : cardsLimites , materias[2] : cardsDerivadas, materias[3] : cardsIntegrais]
        
        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
        var arr = cardsMateria[materia!]!
        
        cell.title.text = arr[indexPath.row]
        cell.textViewConteudo.text = conteudoLimites [indexPath.row]

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


