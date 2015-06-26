//
//  ViewController.swift
//  CardsCollection
//
//  Created by Felipe Marques Ramos on 19/05/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class CardsViewController: UICollectionViewController {
    

    @IBOutlet var titulo: UINavigationItem!
    
    var materia: String?
    var cardsMateria = Dictionary<String,Array<Card>>()
    var cardsConteudos = Dictionary<String,Array<String>>()
    
    var tap: UITapGestureRecognizer?
    
    var conteudoPreCalculoA = Array<String>()
    var conteudoPreCalculoB = Array<String>()
    var conteudoLimitesA = Array<String>()
    var conteudoLimitesB = Array<String>()
    var conteudoDerivadasA = Array<String>()
    var conteudoDerivadasB = Array<String>()
    var conteudoIntegraisA = Array<String>()
    var conteudoIntegraisB = Array<String>()
    var conteudoCalculadoraA = Array<String>()
    var conteudoCalculadoraB = Array<String>()
    var conteudoCanvasA = Array<String>()
    var conteudoCanvasB = Array<String>()
    var conteudoTabsA = Array<String>()
    var conteudoTabsB = Array<String>()

    
    var conteudoImagePreCalculo = Array<String>()
    var conteudoImageLimite = Array<String>()
    var conteudoImageDerivada = Array<String>()
    var conteudoImageIntegral = Array<String>()
    var conteudoImageCalculadora = Array<String>()
    var conteudoImageCanvas = Array<String>()
    var conteudoImageTabs = Array<String>()
    
    var cardsPreCalculo = Array<Card>()
    var cardsLimites = Array<Card>()
    var cardsDerivadas = Array<Card>()
    var cardsIntegrais = Array<Card>()
    var cardsCalculadora = Array<Card>()
    var cardsCanvas = Array<Card>()
    var cardsTabs = Array<Card>()
    
    
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
        
        
        
        tap = UITapGestureRecognizer(target: self , action: "handleTap")
        tap?.numberOfTapsRequired = 2
        
        self.collectionView?.addGestureRecognizer(tap!)
        
        self.titulo.title = materia!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        self.populaCards()
        self.populaConteudo()
        
        materias = [NSLocalizedString("precal",     comment: "pre calculo"),
                    NSLocalizedString("limite",     comment: "limites"),
                    NSLocalizedString("derivada",   comment: "derivada"),
                    NSLocalizedString("integral",   comment: "integral"),
                    NSLocalizedString("mais",       comment: "outro"),
                    NSLocalizedString("calc",       comment: "calculadora"),
                    NSLocalizedString("canvas",     comment: "canvas")
                    ]
        
        
        cardsMateria = [materias[0] : cardsPreCalculo , materias[1] : cardsLimites , materias[2] : cardsDerivadas, materias[3] : cardsIntegrais, materias[4] : cardsTabs, materias[5] : cardsCalculadora, materias[6] : cardsCanvas]
        

        self.collectionView?.collectionViewLayout = self.stackedLayout
        
    }
    
    
    // MARK: DATASOURCE
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCollectionViewCell
        
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: self.collectionView!.frame.width, height: cell.frame.height)
        
        var arr = cardsMateria[materia!]!
        
        cell.title.text = arr[indexPath.row].titulo!
        
        cell.textViewConteudo.attributedText = arr[indexPath.row].conteudo!
        
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
        var arr = cardsMateria[materia!]!
        return arr.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CardCollectionViewCell
        
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
        cardsPreCalculo = [Card(titulo: NSLocalizedString("precal1",  comment: "pre calculo")),
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
            Card(titulo: NSLocalizedString("derivada5",  comment: "derivada")),
            Card(titulo: NSLocalizedString("derivada6",  comment: "derivada")),
            Card(titulo: NSLocalizedString("derivada7",  comment: "derivada"))
        ]
        
        cardsIntegrais = [Card(titulo: NSLocalizedString("integral1",  comment: "integral")),
            Card(titulo: NSLocalizedString("integral2",  comment: "integral")),
            Card(titulo: NSLocalizedString("integral3",  comment: "integral")),
            Card(titulo: NSLocalizedString("integral4",  comment: "integral")),
            Card(titulo: NSLocalizedString("integral5",  comment: "integral")),
            Card(titulo: NSLocalizedString("integral6",  comment: "integral"))
        ]
        
        cardsCalculadora = [Card(titulo: "Calculadora aqui ⬇️")]
        cardsCanvas = [Card(titulo: "Quer fazer um desenho? 😁")]
        
        cardsTabs = [Card(titulo: "Trigonometricas"),Card(titulo: "Derivadas"),Card(titulo: "integrais"),Card(titulo: "Formulas de Recorrencia")]
        
    }
    private func populaConteudo(){
        conteudoPreCalculoA = [NSLocalizedString("conteudoPreCal1A",  comment: "Atenção, precal"),
            NSLocalizedString("conteudoPreCal2A",  comment: "Conjuntos Numericos, precal"),
            NSLocalizedString("conteudoPreCal3A",  comment: "Polinomios, precal"),
            NSLocalizedString("conteudoPreCal4A",  comment: "Trigonometria, precal"),
            NSLocalizedString("conteudoPreCal5A",  comment: "Equacoes, precal"),
            NSLocalizedString("conteudoPreCal6A",  comment: "Inequacoes, precal"),
            NSLocalizedString("conteudoPreCal7A",  comment: "Teste, precal")]
        
        conteudoPreCalculoB = [NSLocalizedString("conteudoPreCal1B",  comment: "Atenção, precal"),
            NSLocalizedString("conteudoPreCal2B",  comment: "Conjuntos Numericos, precal"),
            NSLocalizedString("conteudoPreCal3B",  comment: "Polinomios, precal"),
            NSLocalizedString("conteudoPreCal4B",  comment: "Trigonometria, precal"),
            NSLocalizedString("conteudoPreCal5B",  comment: "Equacoes, precal"),
            NSLocalizedString("conteudoPreCal6B",  comment: "Inequacoes, precal"),
            NSLocalizedString("conteudoPreCal7B",  comment: "Teste, precal")]
        
        
        conteudoLimitesA = [NSLocalizedString("conteudoLimites1A",  comment: "O que é, limite"),
            NSLocalizedString("conteudoLimites2A",  comment: "Definição, limite"),
            NSLocalizedString("conteudoLimites3A",  comment: "Propriedades, limite"),
            NSLocalizedString("conteudoLimites4A",  comment: "Indeterminacoes, limite"),
            NSLocalizedString("conteudoLimites5A",  comment: "Limites laterais e continuidade, limite"),
            NSLocalizedString("conteudoLimites6A",  comment: "Limites Fundamentais, limite"),
            NSLocalizedString("conteudoLimites7A",  comment: "Exercicios Resolvidos, limite"),
            NSLocalizedString("conteudoLimites8A",  comment: "Teste, limite")]
        
        conteudoLimitesB = [NSLocalizedString("conteudoLimites1B",  comment: "O que é, limite"),
            NSLocalizedString("conteudoLimites2B",  comment: "Definição, limite"),
            NSLocalizedString("conteudoLimites3B",  comment: "Propriedades, limite"),
            NSLocalizedString("conteudoLimites4B",  comment: "Indeterminacoes, limite"),
            NSLocalizedString("conteudoLimites5B",  comment: "Limites laterais e continuidade, limite"),
            NSLocalizedString("conteudoLimites6B",  comment: "Limites Fundamentais, limite"),
            NSLocalizedString("conteudoLimites7B",  comment: "Exercicios Resolvidos, limite"),
            NSLocalizedString("conteudoLimites8B",  comment: "Teste, limite")]
        
        
        
        conteudoDerivadasA = [NSLocalizedString("conteudoDerivadas1A",  comment: "O que é, derivada"),
            NSLocalizedString("conteudoDerivadas2A",  comment: "Definição, derivada"),
            NSLocalizedString("conteudoDerivadas3A",  comment: "Notações, derivada"),
            NSLocalizedString("conteudoDerivadas4A",  comment: "Propriedades, derivada"),
            NSLocalizedString("conteudoDerivadas5A",  comment: "Derivadas Trigonometricas, derivada"),
            NSLocalizedString("conteudoDerivadas6A",  comment: "Exercicios Resolvidos, derivada"),
            NSLocalizedString("conteudoDerivadas7A",  comment: "Teste, derivada")]
        
        conteudoDerivadasB = [NSLocalizedString("conteudoDerivadas1B",  comment: "O que é, derivada"),
            NSLocalizedString("conteudoDerivadas2B",  comment: "Definição, derivada"),
            NSLocalizedString("conteudoDerivadas3B",  comment: "Notações, derivada"),
            NSLocalizedString("conteudoDerivadas4B",  comment: "Propriedades, derivada"),
            NSLocalizedString("conteudoDerivadas5B",  comment: "Derivadas Trigonometricas, derivada"),
            NSLocalizedString("conteudoDerivadas6B",  comment: "Exercicios Resolvidos, derivada"),
            NSLocalizedString("conteudoDerivadas7B",  comment: "Teste, derivada")]
        
        conteudoIntegraisA = [NSLocalizedString("conteudoIntegrais1A",  comment: "O que é, integral"),
            NSLocalizedString("conteudoIntegrais2A",  comment: "Definição, integral"),
            NSLocalizedString("conteudoIntegrais3A",  comment: "Propriedades Integrais Indefinidas, integral"),
            NSLocalizedString("conteudoIntegrais4A",  comment: "Métodos, integral"),
            NSLocalizedString("conteudoIntegrais5A",  comment: "Exercicios Resolvidos, integral"),
            NSLocalizedString("conteudoIntegrais6A",  comment: "Teste, integral")]
        
        conteudoIntegraisB = [NSLocalizedString("conteudoIntegrais1B",  comment: "O que é, integral"),
            NSLocalizedString("conteudoIntegrais2B",  comment: "Definição, integral"),
            NSLocalizedString("conteudoIntegrais3B",  comment: "Propriedades Integrais Indefinidas, integral"),
            NSLocalizedString("conteudoIntegrais4B",  comment: "Métodos, integral"),
            NSLocalizedString("conteudoIntegrais5B",  comment: "Exercicios Resolvidos, integral"),
            NSLocalizedString("conteudoIntegrais6B",  comment: "Teste, integral")]
        
        conteudoTabsA = ["","Sejam u e v funções derivaveis e \n n constante","",""]
        conteudoTabsB = ["","","",""]
        
        
        conteudoImagePreCalculo = ["1","conjuntos","3","PreCal-Trigonometria","5","6","7","8"]
        conteudoImageLimite = ["1","2","3","4","5","Limites-Limites Fundamentais","pencil-104","8","9"]
        conteudoImageDerivada = ["1","Derivada - Notacao","Derivada - definicao","4","5","ExDer","7","8"]
        conteudoImageIntegral = ["1","2","3","Integral - Substituicao","ExInt","6","7"]
        conteudoImageCalculadora = ["1","2","3","4","5","6","7","8"]
        conteudoImageCanvas = ["1","2","3","4","5","6","7","8"]
        conteudoImageTabs = ["TabTrig","TabDer","TabInt","TabRec","5","6","7","8"]
        
        for i in 0...cardsLimites.count-1{
            var attString = NSMutableAttributedString(string: conteudoLimitesA[i])
            
            var attImage = NSTextAttachment()
            attImage.image = UIImage(named: conteudoImageLimite[i])
            var imageString = NSAttributedString(attachment: attImage)
            
            attString.appendAttributedString(imageString)
            attString.appendAttributedString(NSMutableAttributedString(string: conteudoLimitesB[i]))
            attString.appendAttributedString(NSAttributedString(string: "\n\n\n\n\n"))
            
            attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino-Roman", size: 20)!, range: NSMakeRange(0, attString.length))
            
            cardsLimites[i].conteudo = attString
        }
        
        
        for i in 0...cardsDerivadas.count-1{
            var attString = NSMutableAttributedString(string: conteudoDerivadasA[i])
            
            var attImage = NSTextAttachment()
            attImage.image = UIImage(named: conteudoImageDerivada[i])
            var imageString = NSAttributedString(attachment: attImage)
            
            attString.appendAttributedString(imageString)
            attString.appendAttributedString(NSMutableAttributedString(string: conteudoDerivadasB[i]))
            attString.appendAttributedString(NSAttributedString(string: "\n\n\n\n\n"))
            
            attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino-Roman", size: 20)!, range: NSMakeRange(0, attString.length))
            cardsDerivadas[i].conteudo = attString
        }
        
        for i in 0...cardsIntegrais.count-1{
            var attString = NSMutableAttributedString(string: conteudoIntegraisA[i])
            
            var attImage = NSTextAttachment()
            attImage.image = UIImage(named: conteudoImageIntegral[i])
            var imageString = NSAttributedString(attachment: attImage)
            
            attString.appendAttributedString(imageString)
            attString.appendAttributedString(NSMutableAttributedString(string: conteudoIntegraisB[i]))
            attString.appendAttributedString(NSAttributedString(string: "\n\n\n\n\n"))
            
            attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino-Roman", size: 20)!, range: NSMakeRange(0, attString.length))
            cardsIntegrais[i].conteudo = attString
        }
        for i in 0...cardsPreCalculo.count-1{
            var attString = NSMutableAttributedString(string: conteudoPreCalculoA[i])
            
            var attImage = NSTextAttachment()
            attImage.image = UIImage(named: conteudoImagePreCalculo[i])
            var imageString = NSAttributedString(attachment: attImage)
            
            attString.appendAttributedString(imageString)
            attString.appendAttributedString(NSMutableAttributedString(string: conteudoPreCalculoB[i]))
            attString.appendAttributedString(NSAttributedString(string: "\n\n\n\n\n"))
            
            attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino-Roman", size: 20)!, range: NSMakeRange(0, attString.length))
            var algmt = NSMutableParagraphStyle()
            algmt.alignment = NSTextAlignment.Justified
    
            attString.addAttribute(NSParagraphStyleAttributeName, value: algmt, range: NSMakeRange(0, attString.length))
            cardsPreCalculo[i].conteudo = attString
        }
        
        for i in 0...cardsTabs.count-1{
            var attString = NSMutableAttributedString(string: conteudoTabsA[i])
            
            var attImage = NSTextAttachment()
            attImage.image = UIImage(named: conteudoImageTabs[i])
            var imageString = NSAttributedString(attachment: attImage)
            
            attString.appendAttributedString(imageString)
            attString.appendAttributedString(NSMutableAttributedString(string: conteudoTabsB[i]))
            attString.appendAttributedString(NSAttributedString(string: "\n\n\n\n\n"))
            
            attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino-Roman", size: 20)!, range: NSMakeRange(0, attString.length))
            cardsTabs[i].conteudo = attString
        }
        
    }
    private func geraCorCards(index: NSIndexPath, corInicial: Int)->UIColor{
        
        //        var red = CGFloat(255 - indexPath.row*25)/255
        //        var green = CGFloat(200 - indexPath.row*25)/255
        //        var blue = CGFloat(150 - indexPath.row*25)/255
        
        var red = CGFloat(corInicial - index.row*15)/255
        var green = CGFloat(corInicial - index.row*15)/255
        var blue = CGFloat(corInicial - index.row*15)/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
  
}


