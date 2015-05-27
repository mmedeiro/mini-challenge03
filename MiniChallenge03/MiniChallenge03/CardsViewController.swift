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
    var cardsMateria = Dictionary<String,Array<Card>>()
    var cardsConteudos = Dictionary<String,Array<String>>()
    
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var cardsPreCalculo = Array<Card>()
    var cardsLimites = Array<Card>()
    var cardsDerivadas = Array<Card>()
    var cardsIntegrais = Array<Card>()
    var cardsCalculadora = Array<Card>()
    var cardsCanvas = Array<Card>()
    var cardsAbout = Array<Card>()
    var cardsLimitesImage = Array<UIImageView>()
    
    var conteudoPreCalculo = Array<String>()
    var conteudoLimites = Array<String>()
    var conteudoDerivadas = Array<String>()
    var conteudoIntegrais = Array<String>()
    
    
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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture.numberOfTapsRequired = 2;
        
        self.navigationController?.navigationBar.backItem?.title! = materia!
        print("OOOOLOKO \(materia) BUUULSHiT")
        
        print(materia)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        cardsPreCalculo = [Card(titulo: NSLocalizedString("precal1",  comment: "pre                     calculo")),
                           Card(titulo: NSLocalizedString("precal2",  comment: "pre calculo")),
                           Card(titulo: NSLocalizedString("precal3",  comment: "pre calculo")),
                           Card(titulo: NSLocalizedString("precal4",  comment: "pre calculo")),
                           Card(titulo: NSLocalizedString("precal5",  comment: "pre calculo")),
                           Card(titulo: NSLocalizedString("precal6",  comment: "pre calculo")),
                           Card(titulo: NSLocalizedString("precal7",  comment: "pre calculo"))
        ]

        cardsLimites = [Card(titulo: NSLocalizedString("limite1",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite2",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite3",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite4",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite5",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite6",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite7",  comment: "limite")),
                        Card(titulo: NSLocalizedString("limite8",  comment: "limite"))
        ]
        
        
        cardsDerivadas = [Card(titulo: NSLocalizedString("derivada1",  comment: "derivada")),
                          Card(titulo: NSLocalizedString("derivada2",  comment: "derivada")),
                          Card(titulo: NSLocalizedString("derivada3",  comment: "derivada")),
                          Card(titulo: NSLocalizedString("derivada4",  comment: "derivada")),
        ]
        
        cardsIntegrais = [Card(titulo: NSLocalizedString("integral1",  comment: "integral")),
                          Card(titulo: NSLocalizedString("integral2",  comment: "integral")),
                          Card(titulo: NSLocalizedString("integral3",  comment: "integral")),
                          Card(titulo: NSLocalizedString("integral4",  comment: "integral")),
                          Card(titulo: NSLocalizedString("integral5",  comment: "integral")),
        ]

        
        cardsCalculadora = [Card(titulo: "Calculadora aqui ⬇️")]
        cardsCanvas = [Card(titulo: "Quer fazer um desenho? 😁")]
        cardsAbout = [Card(titulo: "Esse são cards apenas para o scroll funcionar na view inicial haha")]
        

        conteudoPreCalculo = [NSLocalizedString("conteudoPreCal1",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal2",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal3",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal4",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal5",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal6",  comment: "Atenção, precal"),
                              NSLocalizedString("conteudoPreCal7",  comment: "Atenção, precal")]
        
        
        conteudoLimites = [NSLocalizedString("conteudoLimites1",  comment: "O que é, limite"),
                           NSLocalizedString("conteudoLimites2",  comment: "Definição, limite"),
                           NSLocalizedString("conteudoLimites3",  comment: "Propriedades, limite"), NSLocalizedString("conteudoLimites4",  comment: "Indeterminacoes, limite"),
                           NSLocalizedString("conteudoLimites5",  comment: "Limites laterais e continuidade, limite"),
                           NSLocalizedString("conteudoLimites6",  comment: "Limites Fundamentais, limite"),
                           NSLocalizedString("conteudoLimites7",  comment: "Exercicios Resolvidos, limite"),
                           NSLocalizedString("conteudoLimites8",  comment: "Teste, limite")]
        
        for i in 0...cardsLimites.count-1{
            cardsLimites[i].conteudo = conteudoLimites[i]
        }
        
        conteudoDerivadas = [NSLocalizedString("conteudoDerivadas1",  comment: "O que é, derivada"),
                             NSLocalizedString("conteudoDerivadas2",  comment: "Definição, derivada"),
                             NSLocalizedString("conteudoDerivadas3",  comment: "Notações, derivada"),
                             NSLocalizedString("conteudoDerivadas4",  comment: "Teste, derivada")]
        
        for i in 0...cardsDerivadas.count-1{
            cardsDerivadas[i].conteudo = conteudoDerivadas[i]
        }
        
        conteudoIntegrais = [NSLocalizedString("conteudoIntegrais1",  comment: "O que é, integral"),
                             NSLocalizedString("conteudoIntegrais2",  comment: "Definição, integral"),
                             NSLocalizedString("conteudoIntegrais3",  comment: "Propriedades Integrais Indefinidas, integral"),
                             NSLocalizedString("conteudoIntegrais4",  comment: "Métodos, integral"),
                             NSLocalizedString("conteudoIntegrais5",  comment: "Teste, integral")]
        
        for i in 0...cardsIntegrais.count-1{
            cardsIntegrais[i].conteudo = conteudoIntegrais[i]
        }
        for i in 0...cardsPreCalculo.count-1{
            cardsPreCalculo[i].conteudo = conteudoPreCalculo[i]
        }
        for i in 0...cardsCalculadora.count-1{
            cardsCalculadora[i].conteudo = "hehe"
        }
        for i in 0...cardsCanvas.count-1{
            cardsCanvas[i].conteudo = "hehe"
        }
        for i in 0...cardsAbout.count-1{
            cardsAbout[i].conteudo = "hehe"
        }
        
        materias = [NSLocalizedString("precal",     comment: "pre calculo"),
                    NSLocalizedString("limite",     comment: "limites"),
                    NSLocalizedString("derivada",   comment: "derivada"),
                    NSLocalizedString("integral",   comment: "integral"),
                    NSLocalizedString("calc",       comment: "calculadora"),
                    NSLocalizedString("canvas",     comment: "canvas"),
                    NSLocalizedString("mais",       comment: "outro")]
        
        
        cardsMateria = [materias[0] : cardsPreCalculo , materias[1] : cardsLimites , materias[2] : cardsDerivadas, materias[3] : cardsIntegrais, materias[4] : cardsCalculadora, materias[5] : cardsCanvas, materias[6] : cardsAbout]
        

        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
        var arr = cardsMateria[materia!]!
        
        cell.title.text = arr[indexPath.row].titulo!
        
        var attString = NSMutableAttributedString(string: arr[indexPath.row].conteudo!)
        var attImage = NSTextAttachment()
        attImage.image = UIImage(named: "pencil-104")
        var imageString = NSAttributedString(attachment: attImage)
        attString.replaceCharactersInRange(NSMakeRange(4, 1), withAttributedString: imageString)
        
        cell.textViewConteudo.attributedText = attString

//        var red = CGFloat(255 - indexPath.row*25)/255
//        var green = CGFloat(200 - indexPath.row*25)/255
//        var blue = CGFloat(150 - indexPath.row*25)/255
        var red = CGFloat(220 - indexPath.row*15)/255
        var green = CGFloat(220 - indexPath.row*15)/255
        var blue = CGFloat(220 - indexPath.row*15)/255
        
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//        self.collectionView?.backgroundColor = cell.backgroundColor
        red = CGFloat(200 - indexPath.row*15)/255
        green = CGFloat(200 - indexPath.row*15)/255
        blue = CGFloat(200 - indexPath.row*15)/255
        cell.layer.borderColor = UIColor(red: red, green: green, blue: blue, alpha: 0.75).CGColor
        
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

    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        print("aquele tap")
        if self.exposedIndexPath != nil {
            self.collectionView(self.collectionView!, didSelectItemAtIndexPath: exposedIndexPath!)
        }

    }
  
}


