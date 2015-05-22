//
//  CollectionViewCell.swift
//  MiniChallenge03
//
//  Created by Mariana Medeiro on 22/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        self.layer.cornerRadius = self.frame.width
    }
}
