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
}
