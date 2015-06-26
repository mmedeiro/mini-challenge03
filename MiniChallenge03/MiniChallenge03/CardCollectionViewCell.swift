//
//  CollectionViewCell.swift
//  MiniChallenge03
//
//  Created by Mariana Medeiro on 22/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var textViewConteudo: UITextView!
    
    @IBAction func buttonTeste(sender: AnyObject) {
    }
    @IBOutlet weak var buttonTest: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        self.layer.cornerRadius = self.frame.width/2
//        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 0.45
        
        self.textViewConteudo.backgroundColor = UIColor.clearColor()
        self.textViewConteudo.textAlignment = NSTextAlignment.Right
        self.textViewConteudo.selectable=false
        
//        self.title.font=UIFont(name: "Palatino-Roman", size: 30)
    }
}
