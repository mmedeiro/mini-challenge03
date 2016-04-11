//
//  Card.swift
//  MiniChallenge03
//
//  Created by Felipe Marques Ramos on 26/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class Card: NSObject {
    
    var titulo:String?
    var conteudo:NSMutableAttributedString?
    
    init(titulo:String!){
        self.titulo = titulo
    }
    
    
    init(titulo:String!,conteudoA:Array<NSDictionary>!,width:CGFloat){
        super.init()
        self.titulo = titulo
        createText(conteudoA,width: width)
    }
    
    func createText(conteudoA:Array<NSDictionary>!,width:CGFloat){
        let attString = NSMutableAttributedString()
        
        for items in conteudoA{
            for item in items {
                if (item.key as! String) == "image"{
                    // adiciona imagem na string
                    let attImage = NSTextAttachment()
                    var image = UIImage(named: item.value as! String)
                    
                    image = resizeImage(image!, newWidth: width)
                    
                    attImage.image = image
                    let imageString = NSAttributedString(attachment: attImage)
                    
                    attString.appendAttributedString(imageString)
                }
                else if (item.key as! String) == "text" {
                    //adiciona texto na string
                    let textString = NSAttributedString(string: item.value as! String)
                    attString.appendAttributedString(textString)
                }
            }
        }
        
        let endString = NSAttributedString(string: "\n\n\n\n")
        attString.appendAttributedString(endString)
        
        
        let scale = width/400
        attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino",size:20*scale)!, range: NSMakeRange(0, attString.length))
        
        self.conteudo = attString
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
