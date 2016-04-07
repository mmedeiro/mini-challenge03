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
    
    
    init(titulo:String!,conteudo:Array<NSDictionary>!){
        self.titulo = titulo
        
        let attString = NSMutableAttributedString()
        
        for items in conteudo{
            for item in items {
                if (item.key as! String) == "image"{
                    // adiciona imagem na string
                    let attImage = NSTextAttachment()
                    attImage.image = UIImage(named: item.value as! String)
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
        
        attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Palatino",size:20)!, range: NSMakeRange(0, attString.length))
        

        
        self.conteudo = attString
        
    }
}
